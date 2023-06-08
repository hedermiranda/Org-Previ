public with sharing class IntegrationPensaoController {
    @AuraEnabled
    public static List<IntegrationModels.ConsultaPensaoMorte> getPensoes(String matricula){
        List<IntegrationModels.ConsultaPensaoMorte> retorno = new List<IntegrationModels.ConsultaPensaoMorte>();
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getPensoes(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.ConsultaPensaoMorte>) Json.deserialize(Json.serialize(responseBody.get('consulta_pensao_morte')), List<IntegrationModels.ConsultaPensaoMorte>.class);
                        System.debug('PENSOES >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno; 
    }

    @AuraEnabled
    public static IntegrationModels.ConsultaHistoricoBilhete_Z getHistoricoBilhetes(String matricula){
        IntegrationModels.ConsultaHistoricoBilhete_Z retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistoricoBilhetes(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        retorno = (IntegrationModels.ConsultaHistoricoBilhete_Z) Json.deserialize(responseAPI.getBody(), IntegrationModels.ConsultaHistoricoBilhete_Z.class);                     
                        System.debug('HISTORICO BASES >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno; 
    }

    @AuraEnabled
    public static List<IntegrationModels.ConsultaAposeHistBase> getHistoricoBases(String matricula){
        List<IntegrationModels.ConsultaAposeHistBase> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistoricoBases(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.ConsultaAposeHistBase>) Json.deserialize(Json.serialize(responseBody.get('consulta_apose_hist_base')), List<IntegrationModels.ConsultaAposeHistBase>.class);
                        System.debug('GRUPOS FAMILIARES >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno; 
    }

    @AuraEnabled
    public static List<IntegrationModels.GruposFamiliar> getGruposFamiliar(String matricula){
        List<IntegrationModels.GruposFamiliar> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getGruposFamiliar(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.GruposFamiliar>) Json.deserialize(Json.serialize(responseBody.get('grupo_Familiar')), List<IntegrationModels.GruposFamiliar>.class);
                        System.debug('GRUPOS FAMILIARES >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno; 
    }

    @AuraEnabled
    public static List<IntegrationModels.CalcularPensionista> getPensionistas(String matricula, String grupo){
        List<IntegrationModels.CalcularPensionista> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getPensionistas(matricula, grupo);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.CalcularPensionista>) Json.deserialize(Json.serialize(responseBody.get('calcular_pensionista')), List<IntegrationModels.CalcularPensionista>.class);
                        System.debug('PENSIONISTAS >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno;
    }

    @AuraEnabled
    public static List<IntegrationModels.RecalcPensaoIndividual> getRepresentanteLegal(String matricula, String grupo){
        List<IntegrationModels.RecalcPensaoIndividual> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getRepresentanteLegal(matricula, grupo);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.RecalcPensaoIndividual>) Json.deserialize(Json.serialize(responseBody.get('recalc_pensao_individual')), List<IntegrationModels.RecalcPensaoIndividual>.class);
                        System.debug('Representante Legal >> ' + retorno);                     
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno; 
    }

    @AuraEnabled
    public static List<IntegrationModels.HistoricoPensaoMorte> getHistoricos(String matricula, String grupo, String pensionista){
        List<IntegrationModels.HistoricoPensaoMorte> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getHistoricos(matricula, grupo, pensionista);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.HistoricoPensaoMorte>) Json.deserialize(Json.serialize(responseBody.get('historico_pensao_morte')), List<IntegrationModels.HistoricoPensaoMorte>.class);
                        System.debug('Historicos >> ' + retorno);              
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno; 
    }

    @AuraEnabled
    public static List<IntegrationModels.ConsultaCompleMorte> getComplementoPensao(String matricula){
        List<IntegrationModels.ConsultaCompleMorte> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getComplementoPensao(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.ConsultaCompleMorte>) Json.deserialize(Json.serialize(responseBody.get('consulta_comple_morte')), List<IntegrationModels.ConsultaCompleMorte>.class);
                        System.debug('COMPLE PENSOES >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno;      
    }

    @AuraEnabled
    public static List<IntegrationModels.PendenciaDocumentos> getPendenciaDocumentos(String matricula, String grupo, String pensionista){
        List<IntegrationModels.PendenciaDocumentos> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getPendenciaDocumentos(matricula, grupo, pensionista);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.PendenciaDocumentos>) Json.deserialize(Json.serialize(responseBody.get('pendencia_documentos')), List<IntegrationModels.PendenciaDocumentos>.class);
                        System.debug('PENDENCIA DOCUMENTOS >> ' + retorno);
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno;      
    }

    @AuraEnabled
    public static IntegrationModels.Recadastramento getRecadastramento(String matricula, String ano){
        IntegrationModels.Recadastramento retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getRecadastramento(matricula, ano);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        retorno = (IntegrationModels.Recadastramento) Json.deserialize(responseAPI.getBody(), IntegrationModels.Recadastramento.class);                     
                        System.debug('RECADASTRAMENTO >> ' + retorno);
                    
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno;      
    }

    @AuraEnabled
    public static IntegrationModels.ConcessaoInssPrisma getConcessaoInssPrisma(String matricula){
        IntegrationModels.ConcessaoInssPrisma retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getConcessaoInssPrisma(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        retorno = (IntegrationModels.ConcessaoInssPrisma) Json.deserialize(responseAPI.getBody(), IntegrationModels.ConcessaoInssPrisma.class);                     
                        System.debug('CONCESSAO INSS PRISMA >> ' + retorno);
                    
                    }
                }
            }
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        return retorno;      
    }

    @AuraEnabled
    public static List<IntegrationModels.ConsultaHistAdiantamento> getAdiantamentos(String matricula){
        List<IntegrationModels.ConsultaHistAdiantamento> retorno = null;
        try{
            if(matricula != null) {
                HTTPResponse responseAPI = IntegrationUtils.getAdiantamentos(matricula);
                if(responseAPI != null){
                    if(responseAPI.getStatusCode() == 200){
                        Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                        retorno = (List<IntegrationModels.ConsultaHistAdiantamento>) Json.deserialize(Json.serialize(responseBody.get('consulta_hist_adiantamento')), List<IntegrationModels.ConsultaHistAdiantamento>.class);
                        System.debug('ADIANTAMENTOS >> ' + retorno);
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