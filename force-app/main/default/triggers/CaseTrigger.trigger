trigger CaseTrigger on Case (before update, before insert, after insert, after update) {
    Map<Id,Case> oldMap = Trigger.oldMap;
    List<Case> lstUpdate = new List<Case>();
    if (trigger.isBefore) {
        if(trigger.isUpdate){
            System.debug('Case Before Update');
            for(Case cas : Trigger.new){
                if(cas.Occupation_area__c != oldMap.get(cas.Id)?.Occupation_area__c && cas.Occupation_area__c !=null && cas.ParentId != null){                    
                    System.debug('Entrou para trocar a fila');
                    CaseTriggerHandler.ChangeQueue(Trigger.new, Trigger.oldMap);   
                    System.debug('Alterou para uma fila');                    
                }
            }          
        }else if(trigger.isInsert){
            for(Case cas : Trigger.new){
                List<Account> lstAcc = [SELECT Id FROM Account WHERE Registration__c =: cas.Registration__c];
                if(cas.AccountId != null && cas.ContactId == null && cas.Registration__c ==null){
                    CaseTriggerHandler.getContact(cas.AccountId, Trigger.new);
                }else if(cas.Registration__c !=null && lstAcc.size() > 0){
                    
                    List<Contact> con = [SELECT Id FROM Contact WHERE AccountId =: lstAcc[0].Id];
                    cas.AccountId = lstAcc[0].Id;
                    System.debug('Conta do Case >> ' + lstAcc[0].Id);
                    System.debug('Contato da conta >> ' + con);
                    //cas.ContactId = con != null ? con[0].Id : null;
                }
            }
        }
    }else if (trigger.isAfter) {
        if(trigger.isInsert){
            System.debug('Case After Insert');
            CaseTriggerHandler.updateCase(Trigger.new);                       
        }
               
    }
}