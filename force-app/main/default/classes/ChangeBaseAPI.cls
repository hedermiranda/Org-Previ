public class ChangeBaseAPI {
    @InvocableMethod(label='AlterFildsAPI' description='AlterFildsAPI')
    public static void FieldsAlter(Request[] listInput){
        Try{
            
            String matricula = listInput[0].matricula;
            String TypeAPISession = listInput[0].TypeAPISession;
            
            Contact contato = new Contact();
            contato = !listInput.isEmpty() ? listInput[0].LtsContact : null;
            
            Account conta = new Account();
            conta = !listInput.isEmpty() ? listInput[0].LtsAccount : null;
            
            if(TypeAPISession.contains('Email')){
                system.debug('Call Email');
                
                IntegrationModels.Email cont = new IntegrationModels.Email();
                cont.email = contato.Email;
                system.debug('Aqui ' + matricula +' '+ Json.serialize(cont));
                calloutsCall(matricula , Json.serialize(cont),'PostEmail');
            }
            
            if(TypeAPISession.contains('Telefone')){
                system.debug('Call Telefone');
                IntegrationModels.PutTelefone contTel = new IntegrationModels.PutTelefone();
   
                Map<String,String> mapPhone = putPhone(contato.Phone, contato.MobilePhone);
                contTel.ddd1 = mapPhone.get('dddPhone');
                contTel.ddi1 = null; //contato.DDI__c;
                contTel.telefone1 = mapPhone.get('telPhone');
                contTel.ramal1 = contato.Arm__c;
                 system.debug('contato.Phone  ' + contato.Phone );

                contTel.ddd3 = mapPhone.get('dddMobile');
                contTel.ddi3 = null; //contato.DDI_Mobile__c;
                contTel.telefone3 = mapPhone.get('telMobile');
                contTel.ramal3 = null;
                system.debug('contato.MobilePhone  ' + contato.MobilePhone);

                contTel.ddd2 = null;
                contTel.ddi2 = null;
                contTel.telefone2 = null;
                contTel.ramal2 = null;
                
                contTel.ddd4 = null;
                contTel.ddi4 = null;    
                contTel.fax = contato.Fax;
                
                Map<String,Object> mpJson = new Map<String,Object>();
                mpJson.put('telefone', contTel);
                
                system.debug('Aqui ' + matricula +' '+ Json.serialize(mpJson));

                calloutsCall(matricula , Json.serialize(mpJson),'PutTelefone');             
            }
            if(TypeAPISession.contains('OpcaoCorrespondencia')){
                system.debug('Call OpcaoCorrespondencia');
                List<IntegrationModels.PostOpcoes> listOpc = new List<IntegrationModels.PostOpcoes>();

                IntegrationModels.PostOpcoes opc = new IntegrationModels.PostOpcoes();                
                opc.idCorrespondencia = 20;
                opc.envioPostal = (conta.Income_Tax_Statement__c).contains('Postal') ? 'S' : 'N';
                opc.envioEmail = 'D';
                opc.envioCelular = 'D';
                listOpc.add(opc);
                
                IntegrationModels.PostOpcoes opc2 = new IntegrationModels.PostOpcoes(); 
                opc2.idCorrespondencia = 3;
                opc2.envioPostal = 'D';
                opc2.envioEmail = (conta.Info_Previ__c).contains('Email') ? 'S' : 'N';
                opc2.envioCelular = 'D';
                listOpc.add(opc2);
                
                IntegrationModels.PostOpcoes opc3 = new IntegrationModels.PostOpcoes(); 
                opc3.idCorrespondencia = 9;
                opc3.envioPostal = (conta.Other_Institutional_Info__c).contains('Postal') ? 'S' : 'N';
                opc3.envioEmail = (conta.Other_Institutional_Info__c).contains('Email') ? 'S' : 'N';
                opc3.envioCelular = (conta.Other_Institutional_Info__c).contains('Celular') ? 'S' : 'N';
                listOpc.add(opc3);

                IntegrationModels.PostOpcoes opc4 = new IntegrationModels.PostOpcoes(); 
                opc4.idCorrespondencia = 11;
                opc4.envioPostal = (conta.Card_Benefits_Club__c).contains('Postal') ? 'S' : 'N';
                opc4.envioEmail = (conta.Card_Benefits_Club__c).contains('Email') ? 'S' : 'N';
                opc4.envioCelular = (conta.Card_Benefits_Club__c).contains('Celular') ? 'S' : 'N';
                listOpc.add(opc4);

                IntegrationModels.PostOpcoes opc5 = new IntegrationModels.PostOpcoes(); 
                opc5.idCorrespondencia = 19;
                opc5.envioPostal = (conta.Other_Promotional_Info__c).contains('Postal') ? 'S' : 'N';
                opc5.envioEmail = (conta.Other_Promotional_Info__c).contains('Email') ? 'S' : 'N';
                opc5.envioCelular = (conta.Other_Promotional_Info__c).contains('Celular') ? 'S' : 'N';
                listOpc.add(opc5);

                Map<String,Object> mpJson = new Map<String,Object>();
                mpJson.put('opcoes', listOpc);

                system.debug('Aqui ' + matricula +' '+ Json.serialize(mpJson));
                
                calloutsCall(matricula , Json.serialize(mpJson),'PostOpcaoCorrespondencia');
                
            }
         
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }         
    }
   
    private static Map<String,String> putPhone(String phone, String mobile){
        phone = phone != null ? phone.replaceAll('[^\\d]','') : phone;
        mobile = mobile != null ? mobile.replaceAll('[^\\d]','') : mobile;
        Map<String,String> mapPhone = new Map<String,String>();

        if(phone != null){
            mapPhone.put('dddPhone', phone.substring(0,2));
            mapPhone.put('telPhone', phone.substring(2,phone.length()));
        }else{
            mapPhone.put('dddPhone', null);
            mapPhone.put('telPhone', null);
        }
        
        if(mobile != null){
            mapPhone.put('dddMobile', mobile.substring(0,2));
            mapPhone.put('telMobile', mobile.substring(2,mobile.length()));
        }else{
            mapPhone.put('dddMobile', null);
            mapPhone.put('telMobile', null);
        }

        return mapPhone;        
    }
    
    @future(callout = true)
    private static void calloutsCall(String registration, String body, String metodoName){
        HTTPResponse retorno;

        
        switch on metodoName {
            when 'PostEmail' {		
                retorno = IntegrationUtils.postEmail(registration, body);
            }  
            
            when 'PutTelefone' {
                retorno = IntegrationUtils.putTelefone(registration, body); 
            }
            
            when 'PostOpcaoCorrespondencia' {		                   
                retorno = IntegrationUtils.postOpcaoCorrespondencia(registration, body);
            }
        }
        system.debug('return integration ' + retorno);
        
        if(retorno.getStatusCode() == 200){ system.debug('Sucess');}
    }
    
    public class Request{
        @InvocableVariable(label = 'Matrícula')
        public String matricula;
        
        @InvocableVariable(label = 'LtsContact')
        public Contact LtsContact;
        
        @InvocableVariable(label = 'LtsAccount')
        public Account LtsAccount;
        
        @InvocableVariable(label = 'TypeAPISession')
        public String TypeAPISession;
    }
}