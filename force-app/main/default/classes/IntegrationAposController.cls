public class IntegrationAposController {
    
    @AuraEnabled(cacheable=true)
    public static List<object> getPropostas(String idParticipante, string method, string nomeObj ){
        List<object> retorno = null;
        HTTPResponse responseAPI;
        Try{
            if(idParticipante != null) {
                switch on method {
                    when 'getDadosGerais' {		
                      responseAPI = IntegrationUtils.getDadosGerais(idParticipante);
                    }	
               
                } 
                
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<Object>) Json.deserialize(Json.serialize(responseBody.get(nomeObj)), List<object>.class);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno; 
    }
}