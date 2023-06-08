public with sharing class BillingAddressCustomController {
    
    /**
    * Estrutura de Retorno.
    */
    public class Response  {
        @AuraEnabled public String result { get; set; }
        @AuraEnabled public Boolean success{ get; set; }
    }  
    
    /**
    * Chama a integração de Endereco passando valores de Cadastro alteradas em tela para alterar a base da previ e retorna para o LWC o response, 
    * caso sucesso atualiza no salesforce as alterações nos objetos Contact e Accout.
    */
    @AuraEnabled
    public static Response sendEndereco(Cadastro conta) { 
        
        Response responseEnd = new Response();
        try {
            
            IntegrationModels.EnderecoAtualizar atlz = new IntegrationModels.EnderecoAtualizar();
            atlz.logradouro = (conta.BillingStreet).substringBeforeLast(',');
            string numero = (conta.BillingStreet).substringAfterLast(',');
            atlz.numero = numero.contains('S/N') ? null : numero;
            atlz.complemento = conta.Complemento;
            atlz.bairro = conta.District;
            atlz.municipio = conta.BillingCity.toUpperCase();
            atlz.uf = conta.BillingState.toUpperCase();
            atlz.cep = conta.BillingPostalCode.replace('-','');
            atlz.pais = conta.BillingCountry;  
            
            IntegrationModels.AtualizarEndereco AtEnd = new IntegrationModels.AtualizarEndereco();
            AtEnd.idMatricula = Integer.valueOf(conta.Registration);
            AtEnd.atualizar = atlz;
            
            HTTPResponse retorno = IntegrationUtils.putEndereco(conta.Registration, Json.serialize(AtEnd));
            if(retorno.getStatusCode() == 200){   
                Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(retorno.getBody());
                if(responseBody.containsKey('retorno')) {
                    string msg = JSON.serialize(responseBody.get('retorno'));    
                    if(msg.contains('END_CEP')) {
                        responseEnd.success = false;
                        responseEnd.result = JSON.serialize(msg);
                        
                    } else if(msg.contains('END_LOGRD')){
                        responseEnd.success = false;
                        responseEnd.result = 'Quantidade de Caracteres excedida no campo Rua da Cobrança, máximo: 60';
                        
                    } else if(msg.contains('User-Defined Exception')){
                        responseEnd.success = false;
                        responseEnd.result = 'Atenção, Verifique os dados inseridos em: Estado e Cidade de cobrança!';
                        
                    } else if(msg.contains('SUCESSO')){
                        Contact queriedContact = [SELECT AccountId,Account.District__c,Account.Complemento__c,Account.BillingStreet, Account.BillingCity, Account.BillingCountry, Account.BillingPostalCode, Account.BillingState,MailingStreet,MailingCity,MailingState,MailingCountry,MailingPostalCode
                                                  FROM Contact 
                                                  WHERE AccountId =: conta.AccountId
                                                  LIMIT 1];
                        
                        queriedContact.Account.District__c = conta.District;
                        queriedContact.Account.Complemento__c = conta.Complemento;
                        queriedContact.Account.BillingStreet = conta.BillingStreet;
                        queriedContact.Account.BillingCity = conta.BillingCity; 
                        queriedContact.Account.BillingState = conta.BillingState.toUpperCase(); 
                        queriedContact.Account.BillingCountry = conta.BillingCountry;
                        queriedContact.Account.BillingPostalCode = conta.BillingPostalCode;
                        update queriedContact.Account;
                        
                        queriedContact.MailingStreet = conta.BillingStreet;
                        queriedContact.MailingCity = conta.BillingCity; 
                        queriedContact.MailingState = conta.BillingState.toUpperCase(); 
                        queriedContact.MailingCountry = conta.BillingCountry;
                        queriedContact.MailingPostalCode = conta.BillingPostalCode.replace('-','');
                        update queriedContact;
                        
                        responseEnd.success = true;
                        system.debug('Sucess query responseEnd ' + responseEnd);
                    }else{
                        responseEnd.success = false;
                        responseEnd.result = JSON.serialize(msg);
                    }
                }
                
            }else{
                
                if(Json.serialize(retorno.getBody()) != ''){
                    responseEnd.success = false;
                    responseEnd.result = 'Por favor, verifique se o Estado e a Cidade de cobrança estão corretos! ';  
                }else{
                    responseEnd.success = false;
                    responseEnd.result = ' Internal Server Error ';
                    system.debug('Error != 200 e não tem retorno');
                }
            }
            
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());      
        } 
        
        return responseEnd;
    }
    
    
    public class Cadastro {
        @AuraEnabled public String BillingStreet { get; set; }
        @AuraEnabled public String Complemento { get; set; }
        @AuraEnabled public String District { get; set; }
        @AuraEnabled public String BillingCity { get; set; }
        @AuraEnabled public String BillingState { get; set; }        
        @AuraEnabled public String BillingPostalCode { get; set; }        
        @AuraEnabled public String BillingCountry { get; set; }
        @AuraEnabled public String Registration { get; set; }
        @AuraEnabled public String AccountId { get; set; }      
    } 
    
}