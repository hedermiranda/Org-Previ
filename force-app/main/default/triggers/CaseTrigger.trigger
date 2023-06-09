trigger CaseTrigger on Case (before update, before insert, after insert, after update) {
    Map<Id,Case> oldMap = Trigger.oldMap;
    List<Case> lstUpdate = new List<Case>();
    if (trigger.isBefore) {
        if(trigger.isUpdate){
            System.debug('Case Before Update');
            for(Case cas : Trigger.new){
                if(cas.Occupation_area__c != oldMap.get(cas.Id)?.Occupation_area__c && cas.Occupation_area__c !=null && cas.CPF__c !=null && cas.ParentId != null && cas.RecordTypeId != '0125C00000173CgQAI' &&  cas.RecordTypeId != '0125C0000017KITQA2'){                    
                    System.debug('Entrou para trocar a fila');
                    CaseTriggerHandler.ChangeQueue(Trigger.new, Trigger.oldMap);   
                    System.debug('Alterou para uma fila');                    
                }
            }          
        }else if(trigger.isInsert){
            for(Case cas : Trigger.new){
                if(cas.CPF__c != null && cas.Origin == 'WEB'){
                    List<Contact> lstCtt = [SELECT Id FROM Contact WHERE CPF__c =: cas.CPF__c];	
                    if(lstCtt.size() != 0){
                        cas.ContactId= lstCtt[0].Id;
                    }                    
                }else if(cas.CPF__c == null && cas.Registration__c != null){
                    List<Account> lstAcc = [SELECT Id FROM Account WHERE Registration__c =: cas.Registration__c];
                    if(cas.AccountId != null && cas.ContactId == null && cas.Registration__c ==null){
                        CaseTriggerHandler.getContact(cas.AccountId, Trigger.new);
                    }else if(cas.Registration__c !=null && lstAcc.size() > 0){                    
                        Contact con = [SELECT Id FROM Contact WHERE AccountId =: lstAcc[0].Id];
                        cas.AccountId = lstAcc[0].Id;
                        cas.ContactId = con.Id;
                    }
                }
            }
        }
    }else if (trigger.isAfter) {
        if(trigger.isInsert){
            System.debug('Case After Insert');
            CaseTriggerHandler.updateCase(Trigger.new);                       
        }/*else if(trigger.isUpdate){
for(Case cas : Trigger.new){
if(oldMap.get(cas.Id).ContactId != null && oldMap.get(cas.Id).ContactId != cas.ContactId){
System.debug('Entrou para trocar contato');
Contact con = [SELECT Id, AccountId FROM Contact WHERE Id =: cas.ContactId];
System.debug('Conta Antiga : ' + cas.AccountId);
System.debug('cas.AccountId >> ' + cas.AccountId);
System.debug('con.AccountId >> ' + con.AccountId);
cas.AccountId = con.AccountId;
System.debug('Conta Nova : ' + cas.AccountId);
CaseTriggerHandler.changeContact(Trigger.new);
lstUpdate.add(cas);
} 
}
if(lstUpdate.size()>0){
updateCase(lstUpdate[0].Id, lstUpdate[0].AccountId);                
}
}*/
        
    }
    /*
@future (callout=true)
public static void updateCase(String caseID, String AccountId) {
Case cas = [SELECT Id, AccountId FROM Case WHERE Id =: caseID];
cas.AccountId = AccountId;
Update cas;
}*/
}