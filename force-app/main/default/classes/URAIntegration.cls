@RestResource(urlMapping='/caseura/*')
global class URAIntegration {
    global class RequestWS {
        String cpf {get;set;}
        String matricula {get;set;}
        String autenticacao {get;set;}
    }

    global class ResponseWS {
        String caseId {get;set;}
    }
//matricula integer cpf string
    @httpGet
    global static ResponseWS getAccount(){
        restRequest request= RestContext.Request;

        RequestWS caseUra = new RequestWS();
        caseUra.cpf = request.params.get('cpf');
        caseUra.matricula = request.params.get('matricula');
        caseUra.autenticacao = request.params.get('autentic');

        System.debug('CPF >> ' + caseUra.cpf + ' MATRICULA >> '+ caseUra.matricula + ' AUTENTICACAO >> ' + caseUra.autenticacao);
        
        Case cas = new Case();
        if(caseUra.matricula != null && caseUra.matricula.length() != 11){
            List<Account> lstAcc =[Select Id, Name from account where Registration__c =: caseUra.matricula];
            cas.AccountId = lstAcc.size() > 0 ? lstAcc[0].Id: null;
        }else if(caseUra.cpf != null){
           List<Contact> lstCont =[select Id, Name, AccountId from contact where CPF__c  =: caseUra.cpf];
           cas.AccountId = lstCont.size() > 0 ? lstCont[0].Id: null;
        }
        if(caseUra.autenticacao != null && caseUra.autenticacao != 'Sim' && caseUra.autenticacao != 'Nao'){
            RecordType recordId = [Select id from RecordType where DeveloperName = 'Atendimento'];
            cas.RecordTypeId = recordId.id;
        }else{
            RecordType recordId = [Select id from RecordType where DeveloperName = 'Participant'];
            cas.RecordTypeId = recordId.id;
        }

                
        insert cas;
        System.debug('Cas.Id >> ' + cas.Id + '\nCas.CaseNumber >> ' + cas.CaseNumber);

        cas = [SELECT CaseNumber from case where Id =: cas.id];
        System.debug('Cas.Id >> ' + cas.Id + '\nCas.CaseNumber >> ' + cas.CaseNumber);

        ResponseWS response = new ResponseWS();
        response.caseId = cas.Id;
        return response;
    }
}