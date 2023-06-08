@isTest
private class BillingAddressCustomControllerTest {
    
    @testSetup
    public static void setup(){
        Account Cadastro = createAccount('nome Sobrenome', '8192884571', '600');
        Contact contato = createContact('nome','Sobrenome','email@teste.com',Cadastro.phone,Cadastro.Id);
    }
    
    
    @isTest static void sendEnderecoTest(){   
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());      
        Contact contato = [SELECT AccountId, Account.District__c, Account.Registration__c, Account.Complemento__c, Account.BillingStreet, Account.BillingCity, Account.BillingCountry, Account.BillingPostalCode, Account.BillingState FROM Contact LIMIT 1];        
        
        BillingAddressCustomController.Cadastro cadastro = new BillingAddressCustomController.Cadastro(); 
        cadastro.BillingStreet = contato.Account.BillingStreet;
        cadastro.Complemento = contato.Account.Complemento__c;
        cadastro.District = contato.Account.District__c; 
        cadastro.BillingCity = contato.Account.BillingCity ; 
        cadastro.BillingState = contato.Account.BillingState;       
        cadastro.BillingPostalCode = contato.Account.BillingPostalCode;       
        cadastro.BillingCountry = contato.Account.BillingCountry; 
        cadastro.Registration = contato.Account.Registration__c; 
        cadastro.AccountId = contato.AccountId;   
        BillingAddressCustomController.Response retorno = BillingAddressCustomController.sendEndereco(cadastro);
        
        System.assert(retorno.success == true);
        
        Test.stopTest();    
    }
    
    @isTest static void sendEnderecoFailTest(){   
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());      
        Contact contato = [SELECT AccountId, Account.District__c, Account.Registration__c, Account.Complemento__c, Account.BillingStreet, Account.BillingCity, Account.BillingCountry, Account.BillingPostalCode, Account.BillingState FROM Contact LIMIT 1];        
        
        BillingAddressCustomController.Cadastro cadastro = new BillingAddressCustomController.Cadastro(); 
        cadastro.BillingStreet = contato.Account.BillingStreet;
        cadastro.Complemento = contato.Account.Complemento__c;
        cadastro.District = null; 
        cadastro.BillingCity = null; 
        cadastro.BillingState = null;       
        cadastro.BillingPostalCode = contato.Account.BillingPostalCode;       
        cadastro.BillingCountry = null; 
        cadastro.Registration = contato.Account.Registration__c; 
        cadastro.AccountId = contato.AccountId;   
        BillingAddressCustomController.Response retorno = BillingAddressCustomController.sendEndereco(cadastro);
        
        
        System.assert(retorno.result == null);
        
        Test.stopTest();    
    }
    private static Contact createContact(String firstName, String lastName,String email, String phone, String acountId){    
        Contact contato = new Contact();
        contato.Phone = phone;
        contato.FirstName = firstName;
        contato.LastName = lastName;   
        contato.email = email;
        contato.AccountId = acountId;
        
        insert contato;
        return contato;
    }
    
    
    private static account createAccount(string name, string phone, String registration){
        Account Cadastro = new Account();
        Cadastro.Name = name;
        Cadastro.phone = phone;
        Cadastro.Registration__c = registration;
        Cadastro.District__c = 'District';
        Cadastro.Complemento__c = 'Complemento';
        Cadastro.BillingStreet = 'BillingStreet';
        Cadastro.BillingCity = 'BillingCity'; 
        Cadastro.BillingState = 'BillingState'; 
        Cadastro.BillingCountry = 'BillingCountry';
        Cadastro.BillingPostalCode = 'BillingPostalCode';
        
        insert Cadastro;
        return Cadastro;        
    }
    
    
}