public with sharing class HistoricosController {
        
    @AuraEnabled
    public static List<IntegrationModels.Protocolo> getProtocolos(String matricula, String idOrigemMatricula){
        List<IntegrationModels.Protocolo> protocolos = new List<IntegrationModels.Protocolo>();
        Try{
            if(matricula != null && idOrigemMatricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getProtocolos(matricula, idOrigemMatricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        protocolos = (List<IntegrationModels.Protocolo>) Json.deserialize(Json.serialize(responseBody.get('protocolo')), List<IntegrationModels.Protocolo>.class);
                        System.debug('protocolos >> ' + protocolos);
                        

                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return protocolos; 
    }

    @AuraEnabled
    public static List<IntegrationModels.ConsultaHistFuncoes> getFuncoes(String matricula){
        List<IntegrationModels.ConsultaHistFuncoes> funcoes = new List<IntegrationModels.ConsultaHistFuncoes>();
        Try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistFuncoes(matricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        funcoes = (List<IntegrationModels.ConsultaHistFuncoes>) Json.deserialize(Json.serialize(responseBody.get('consulta_hist_funcoes')), List<IntegrationModels.ConsultaHistFuncoes>.class);
                        System.debug('FUNCOES >> ' + funcoes);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return funcoes; 
    }

    @AuraEnabled
    public static List<IntegrationModels.ConsultaSituacaoFuncoes> getHistSituacoesFuncionais(String matricula){
        List<IntegrationModels.ConsultaSituacaoFuncoes> situFunc = new List<IntegrationModels.ConsultaSituacaoFuncoes>();
        Try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistSituacoesFuncionais(matricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        situFunc = (List<IntegrationModels.ConsultaSituacaoFuncoes>) Json.deserialize(Json.serialize(responseBody.get('consulta_situacao_funcoes')), List<IntegrationModels.ConsultaSituacaoFuncoes>.class);
                        System.debug('situFunc >> ' + situFunc);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return situFunc; 
    }

    @AuraEnabled
    public static List<IntegrationModels.LicencaInteresses> getLicencaInteresses(String matricula){
        List<IntegrationModels.LicencaInteresses> licIntere = null;
        Try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getLicencaInteresses(matricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        licIntere = (List<IntegrationModels.LicencaInteresses>) Json.deserialize(Json.serialize(responseBody.get('consulta_interesses')), List<IntegrationModels.LicencaInteresses>.class);
                        System.debug('licIntere >> ' + licIntere);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return licIntere; 
    }

    @AuraEnabled
    public static List<IntegrationModels.RepresentantesLegais> getRepresentantesLegais(String matricula){
        List<IntegrationModels.RepresentantesLegais> repLegal = null;
        Try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getRepresentantesLegais(matricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        repLegal = (List<IntegrationModels.RepresentantesLegais>) Json.deserialize(Json.serialize(responseBody.get('consulta_repres_legal')), List<IntegrationModels.RepresentantesLegais>.class);
                        System.debug('repLegal >> ' + repLegal);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return repLegal;
    }
    
    @AuraEnabled
    public static List<IntegrationModels.HistEmail> getHistEmail(String matricula){
        List<IntegrationModels.HistEmail> emails = null;
        Try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistEmail(matricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        emails = (List<IntegrationModels.HistEmail>) Json.deserialize(Json.serialize(responseBody.get('consulta_hist_emails')), List<IntegrationModels.HistEmail>.class);
                        System.debug('emails >> ' + emails);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return emails;
    }

    @AuraEnabled
    public static List<IntegrationModels.HistEndereco> getHistEnderecos(String matricula){
        List<IntegrationModels.HistEndereco> enderecos = null;
        Try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistEnderecos(matricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        enderecos = (List<IntegrationModels.HistEndereco>) Json.deserialize(Json.serialize(responseBody.get('consulta_hist_ends')), List<IntegrationModels.HistEndereco>.class);
                        System.debug('enderecos >> ' + enderecos);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return enderecos;
    }

    @AuraEnabled
    public static List<IntegrationModels.HistTelefones> getHistTelefones(String matricula){
        List<IntegrationModels.HistTelefones> telefones = null;
        Try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistTelefones(matricula);
                if(responseAPI.getStatusCode() == 200){
                    if(responseAPI != null){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        telefones = (List<IntegrationModels.HistTelefones>) Json.deserialize(Json.serialize(responseBody.get('consulta_hist_tels')), List<IntegrationModels.HistTelefones>.class);
                        System.debug('telefones >> ' + telefones);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return telefones;
    }
}