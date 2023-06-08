@isTest
private class ChangeBaseAPITest {
    
    @testSetup
    public static void setup(){
        Contact contato = createContact('teste3','teste4','email@teste.com','8192884571');
        Account Cadastro = createAccount('teste', contato.Phone, contato.Email, '600');
    }
    
    @isTest static void FieldsAlterEmailTest(){   
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];
        Contact contato = [SELECT Id,email FROM Contact LIMIT 1];        
        
        ChangeBaseAPI.Request req = new ChangeBaseAPI.Request();  
        req.TypeAPISession = 'Email';
        req.matricula = conta.Registration__c;
        req.LtsContact = contato;
        
        List<ChangeBaseAPI.Request> listRequest = new List<ChangeBaseAPI.Request>();
        listRequest.add(req);
        
        ChangeBaseAPI.FieldsAlter(listRequest); 
        
        Test.stopTest();    
    }
    
    @isTest static void FieldsAlterTelefone(){   
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];
        Contact contato = [SELECT Id,email,DDD_Mobile__c,DDI_Mobile__c,MobilePhone,Phone2__c,Phone,DDI_principal__c,DDD_principal__c,DDI__c,DDD__c,Arm_Principal__c,Arm__c,Fax FROM Contact LIMIT 1];        
        
        ChangeBaseAPI.Request req = new ChangeBaseAPI.Request();  
        req.TypeAPISession = 'Telefone';
        req.matricula = conta.Registration__c;
        req.LtsContact = contato;
        
        List<ChangeBaseAPI.Request> listRequest = new List<ChangeBaseAPI.Request>();
        listRequest.add(req);
        
        ChangeBaseAPI.FieldsAlter(listRequest); 
        
        Test.stopTest();    
    }
    
    @isTest static void FieldsAlterEndereco(){   
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];
        
        ChangeBaseAPI.Request req = new ChangeBaseAPI.Request();  
        req.TypeAPISession = 'Endereco';
        req.matricula = conta.Registration__c;
        req.LtsAccount = conta;
        
        List<ChangeBaseAPI.Request> listRequest = new List<ChangeBaseAPI.Request>();
        listRequest.add(req);
        
        ChangeBaseAPI.FieldsAlter(listRequest); 
        
        Test.stopTest();    
    }
    
    @isTest static void FieldsAlterOpcaoCorrespondencia(){   
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Account conta = [SELECT Id,Registration__c,Income_Tax_Statement__c,Info_Previ__c,Other_Institutional_Info__c,Card_Benefits_Club__c,Other_Promotional_Info__c FROM Account LIMIT 1];
        
        ChangeBaseAPI.Request req = new ChangeBaseAPI.Request();  
        req.TypeAPISession = 'OpcaoCorrespondencia';
        req.matricula = conta.Registration__c;
        req.LtsAccount = conta;
        
        List<ChangeBaseAPI.Request> listRequest = new List<ChangeBaseAPI.Request>();
        listRequest.add(req);
        
        ChangeBaseAPI.FieldsAlter(listRequest); 
        
        Test.stopTest();    
    }
    
    private static Contact createContact(string firstName, string lastName, string email, string phone){    
        Contact contato = new Contact();
        contato.Phone = phone;
        contato.FirstName = firstName;
        contato.LastName = lastName;   
        contato.email = email;
        contato.DDD_Mobile__c = null;
        contato.MobilePhone = null;
        contato.Phone2__c = null;
        contato.DDI_principal__c = null;
        contato.DDI__c = null;
        contato.DDD__c = null;
        contato.DDI_principal__c = null;
        contato.DDI_Mobile__c = null;
        contato.MobilePhone = null;
        contato.Arm_Principal__c = null;
        contato.Arm__c = null;
        contato.Fax = null;
        
        insert contato;
        return contato;
    }
    
    
    private static account createAccount(string name, string phone, String email, String registration){
        Account Cadastro = new Account();
        Cadastro.Name = name;
        Cadastro.phone = phone;
        Cadastro.Registration__c = registration;
        Cadastro.Income_Tax_Statement__c = 'Postal';
        Cadastro.Info_Previ__c = 'Email';
        Cadastro.Other_Institutional_Info__c = 'Email';
        Cadastro.Card_Benefits_Club__c = 'Email';
        Cadastro.Other_Promotional_Info__c = 'Email';
        
        insert Cadastro;
        return Cadastro;        
    }
    
}