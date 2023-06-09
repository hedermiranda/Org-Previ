@isTest
public class IntegrationUtilsTest {
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
}