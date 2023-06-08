global class IntegrationAccountSCScheduler implements Schedulable, Database.AllowsCallouts{
    global void execute(SchedulableContext sc){     
        calloutAPI();     
    }
    
    
    @future(callout=true)
    public static void calloutAPI(){
        system.debug('entrou');
        List<Account> listAUX = new List<Account>();
        List<ServiceContract> listServCont = new List<ServiceContract>();
        integer limitRegistos = 15;
        integer QtdeRegistos;
        
        QtdeRegistos =  [SELECT Count() FROM ACCOUNT Where CPF__PC != null AND isCreateServiceContract__c = false LIMIT :limitRegistos];
        List<Account> contas = [SELECT id,CPF__PC ,isCreateServiceContract__c FROM ACCOUNT Where CPF__PC != null AND isCreateServiceContract__c = false LIMIT :limitRegistos];
        
        
        Try{
            if(contas.size() > 0) {
                For(Account conta : contas){
                    HTTPResponse responseAPI = IntegrationUtils.calloutMatriculas(conta.CPF__PC);
                    if(responseAPI != null){
                        if(responseAPI.getStatusCode() == 200){
                            Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(responseAPI.getBody());
                            List<dadosAssociado> retorno = (List<dadosAssociado>) Json.deserialize(Json.serialize(responseBody.get('dadosAssociado')), List<dadosAssociado>.class); 
                            for(dadosAssociado item : retorno){
                                ServiceContract sc = new ServiceContract();
                                sc.AccountId = conta.id;
                                sc.Matricula__c = String.valueOf(item.matricula);
                                sc.Name = String.valueOf(item.nomeCompleto); 
                                sc.Plano__c = String.valueOf(item.plano) ;
                                listServCont.add(sc);
                                String aux = JSON.serialize(sc);
                                calloutGetCadastro(aux);
                                conta.isCreateServiceContract__c = true;
                               }
                            }                          
                            listAUX.add(conta);
                        }
                    }
                }
           
            
        }catch(exception e){
            System.debug('Linha ' + e.getLineNumber() + 'Message ' + e.getMessage());         
        }  
        
        insert(listServCont) ;
        update(listAUX);
        System.debug('QtdeRegistos: ' + QtdeRegistos  + ' limitRegistos: ' + limitRegistos);

        if(QtdeRegistos > limitRegistos){
            extraBatch();
        }
    }

    //@future(callout=true)
    public static void calloutGetCadastro(String ServiceCString){
        ServiceContract ServiceCObj = (ServiceContract) JSON.deserialize(ServiceCString, ServiceContract.class);
        
        Map<String,Object> returnCadastro = IntegrationUtils.getCadastro(String.valueOf(ServiceCObj.Matricula__c));                          
        system.debug('returnCadastro ' + returnCadastro);

        if(returnCadastro.get('statusCode') == 200){
        IntegrationModels.CadastroResponse cad = (IntegrationModels.CadastroResponse) JSON.deserialize((String) returnCadastro.get('body'), IntegrationModels.CadastroResponse.class);
        Map<String,String> mapStatus = CaseTriggerHelper.getStatus(cad.cadastro.codPlano,cad.cadastro.situacaoPrevi,cad.cadastro.statusPrevi,String.valueOf(cad.cadastro.codSituacaoEmpresa));
        
        ServiceCObj.StatusApi__c = mapStatus.get(cad.cadastro.situacaoPrevi+cad.cadastro.statusPrevi);
        update ServiceCObj;
    }  
}
    public static void extraBatch(){
        
        String day = string.valueOf(system.now().day());
        String month = string.valueOf(system.now().month());
        String hour = string.valueOf(system.now().hour());
        String minute = string.valueOf(system.now().minute() + 1);
        String second = string.valueOf(system.now().second());
        String year = string.valueOf(system.now().year());
        
        String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
        String strJobName = 'IntegrationAccountSCScheduler Extra : ' + day + '/' + month + '/' + year + ' ' + hour + ':' + minute;
        
        
        IntegrationAccountSCScheduler sc = new IntegrationAccountSCScheduler();
        if(!Test.isRunningTest()){
            string JobId = system.schedule(strJobName, strSchedule, sc);
        }
    }
    
    
    public class dadosAssociado {
        public Integer num_seq_client {get; set;}
        public Integer matricula{get; set;}
        public String cpf{get; set;}
        public Integer plano{get; set;}
        public String nomeCompleto{get; set;}
    }
    
}