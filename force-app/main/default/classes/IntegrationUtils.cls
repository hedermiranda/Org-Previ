public with sharing class IntegrationUtils {
    
    public static dadosCadastrais__mdt dadosCadastrais =  dadosCadastrais__mdt.getInstance('dadosCadastrais');

    
    public static Map<String,Object> getEmail(String matricula) {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + matricula + '/email';
        Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
   
    public static Map<String,Object> getCadastro(String matricula) {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + matricula;
        Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
    
    public static Map<String,Object> getEndereco(String matricula) {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + matricula + '/enderecos';
        Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
    
    public static Map<String,Object> getOpcoesCorrespondencia(String matricula) {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + matricula + '/opcoes-correspondencia';
        Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
    
    public static Map<String,Object> getPPE(String cpf) {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + cpf + '/historicos-ppe';
        Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
    
    public static Map<String,Object> getTelefones(String matricula) {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + matricula + '/telefones';
        //Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
    
    public static Map<String,Object> getPaises() {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + '/paises';
        //Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
    
    public static Map<String,Object> getMunicipiosBrasileiros() {
        String endpoint = 'https://apigatewayhmg.previ.com.br/previ/hmg/dados-cadastrais-participante/v1/cadastro/' + '/municipios-brasileiros';
        Map<String,Object> mapResponse = !Test.isRunningTest() ? IntegrationServices.sendGetRequest(endpoint) : testAuxiliary;
        return IntegrationServices.sendGetRequest(endpoint);
    }
    
    public static HTTPResponse PostEmail(String registration, String body) {
        return IntegrationServices.syncCallout(
            'Email',
            new List<String> {registration},
            null,
            new Map<String,String> { 'Content-Type' => 'application/json','x-ibm-client-secret' => dadosCadastrais.ClientSecret__c, 'x-ibm-client-id' => dadosCadastrais.ClientId__c },
            body);
    }
    
    public static HTTPResponse PutTelefone(String registration, String body) {
        return IntegrationServices.syncCallout(
            'Telefone',
            new List<String> {registration},
            null,
            new Map<String,String> { 'Content-Type' => 'application/json','x-ibm-client-secret' => dadosCadastrais.ClientSecret__c, 'x-ibm-client-id' => dadosCadastrais.ClientId__c },
            body);
    }
    
    public static HTTPResponse PutEndereco(String registration, String body) {
        return IntegrationServices.syncCallout(
            'Endereco',
            new List<String> {registration},
            null,
            new Map<String,String> { 'Content-Type' => 'application/json','x-ibm-client-secret' => dadosCadastrais.ClientSecret__c, 'x-ibm-client-id' => dadosCadastrais.ClientId__c },
            body); 
    }
    
    public static HTTPResponse PostOpcaoCorrespondencia(String registration, String body) {
        return IntegrationServices.syncCallout(
            'OpcoesCorrespondencia',
            new List<String> {registration},
            null,
            new Map<String,String> { 'Content-Type' => 'application/json','x-ibm-client-secret' => dadosCadastrais.ClientSecret__c, 'x-ibm-client-id' => dadosCadastrais.ClientId__c },
            body); 
    }


         
    
    
    @testVisible
    private static Map<String,Object> testAuxiliary;
}