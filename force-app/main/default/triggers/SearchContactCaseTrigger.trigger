trigger SearchContactCaseTrigger on Case (after insert, after update, after delete, after undelete) {
    Set<Id> contactIds = new Set<Id>();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Case record : Trigger.new) {
            contactIds.add(record.ContactId);
        }
    }
    
    if (Trigger.isDelete) {
        for (Case record : Trigger.old) {
            contactIds.add(record.ContactId);
        }
    }
    
    if (Trigger.isUndelete) {
        for (Case record : Trigger.new) {
            contactIds.add(record.ContactId);
        }
    }
    
    contactIds.remove(null);
    
    Map<Id, Contact> contactsToUpdate = new Map<Id, Contact>([SELECT Id, Quantidade_de_Casos__c, (SELECT Id FROM Cases WHERE Status = 'Aguardando Retorno' OR (Status = 'Aguardando 2° nível' AND Sub_Status__c = 'Revisado')) FROM Contact WHERE Id IN :contactIds]);
    
    for (Id contactId : contactsToUpdate.keySet()) {
        contactsToUpdate.get(contactId).Quantidade_de_Casos__c = contactsToUpdate.get(contactId).Cases.size();
    }
    
    update contactsToUpdate.values();
}