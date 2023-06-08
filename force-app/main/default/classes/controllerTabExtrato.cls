public with sharing class controllerTabExtrato {
   @AuraEnabled(cacheable=true)
    public static List<AccountWrapper> getTreeGridData(){
        List<Account> accs = [Select ID , Name, (Select ID , Name from Contacts) from Account];
        List<AccountWrapper> aooo = new List<AccountWrapper>();
        for(Account a : accs){
            AccountWrapper aWraper = new AccountWrapper() ; 
            aWraper.Id =a.Id ;
            aWraper.Name =a.Id ;
            List<ContactWrapper> co = new List<ContactWrapper>();
            for(Contact c : a.Contacts){
                ContactWrapper conWrapp = new ContactWrapper();
                conWrapp.Id =c.Id ;
                conWrapp.Name =c.Name ;
                co.add(conWrapp);
            }
            aWraper.contacts = co;
            aooo.add(aWraper);
            
        }
        return aooo;
    } 
    public Class AccountWrapper{
        @AuraEnabled
        public String Id {get;set;}
        @AuraEnabled
        public String Name {get;set;}
        @AuraEnabled
        public List<ContactWrapper> contacts {get;set;}
    }
    
    public Class ContactWrapper{
        @AuraEnabled
        public String Id {get;set;}
        @AuraEnabled
        public String Name {get;set;}
    }
}