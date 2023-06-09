@isTest
private class classIntegrationUtilsTest {
    
   	@isTest
    static void getEmailTest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getEmail('600');
    }
    
    @isTest
    static void getCadastroTest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getCadastro('600');
    }
    
    @isTest
    static void getEnderecoTest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getEndereco('600');
    }
    
    @isTest
    static void getOpcoesCorrespondenciaTest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getOpcoesCorrespondencia('600');
    }
    @isTest
    static void getPPETest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getPPE('600');
    }
    @isTest
    static void getTelefonesTest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getTelefones('600');
    }
    @isTest
    static void getPaisesTest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getPaises();
    }
    @isTest
    static void getMunicipiosBrasileirosTest(){
        IntegrationUtils.testAuxiliary = new Map<String,Object>{'statusCode' => '200', 'body' => 'd'};
        IntegrationUtils.getMunicipiosBrasileiros();
    }
    @isTest
    static void PutEnderecoTest(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.assert(IntegrationUtils.PutEndereco('600','{"atualizar":{"logradouro":"RUA VEREADOR DEOCLECIANO RAMOS","numero":351,"complemento":"SALA 01","bairro":"SUICA","municipio":"Calgary","uf":"SE","cep":"49050750","pais":"Brasil"},"idMatricula":12345678}') != null);
    }
    
    @isTest
    static void PostEmailTest(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.assert(IntegrationUtils.PostEmail('600','{"email":"leonardo3@1235testgmail.com"}') != null);
    }
    
    @isTest
    static void PutTelefoneTest(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.assert(IntegrationUtils.PutTelefone('600','{"telefone":{"ddd1":"et reprehenderit sunt","ddi1":"commodo in voluptate","ddd2":"labore occaecat do a","ddi2":"minim id sed ex","ddd3":"ut","ddi3":"dolore in velit","ddd4":"aute cupidatat nostrud in mollit","ddi4":"culpa pariatur sed cillum","telefone1":"Lorem mollit","telefone2":"ut voluptate","telefone3":"occaecat aliqua sed do","ramal1":"cillum nisi aute et","ramal2":"consectetur officia incididunt aliqua","ramal3":"sint exercitation eu","fax":"laboris nisi"}}') != null);
    }
    
    @isTest
    static void PostOpcaoCorrespondenciaTest(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.assert(IntegrationUtils.PostOpcaoCorrespondencia('600','{"opcaoCorrespondencia":{"idCorrespondencia":3,"correspondencia":"InfPREVI","envioPostal":"N","envioEmail":"N","envioCelular":"D"}}') != null);
    }
    
}