public with sharing class IntegrationSenhaController {
    @AuraEnabled
    public static List<IntegrationModels.Alteracoes> getHistoricosSenha(String matricula){
        List<IntegrationModels.Alteracoes> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistoricosSenha(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.Alteracoes>) Json.deserialize(Json.serialize(responseBody.get('alteracoes')), List<IntegrationModels.Alteracoes>.class);
                        System.debug('HISTORICOS SENHAS >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno;
    }

    @AuraEnabled
    public static List<IntegrationModels.Solicitacoes> getSolicitacoesTroca(String matricula){
        List<IntegrationModels.Solicitacoes> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getSolicitacoesTroca(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.Solicitacoes>) Json.deserialize(Json.serialize(responseBody.get('solicitacoes')), List<IntegrationModels.Solicitacoes>.class);
                        System.debug('SOLICITACOES >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno;      
    }
}