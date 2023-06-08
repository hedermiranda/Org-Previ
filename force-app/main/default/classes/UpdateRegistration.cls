public with sharing class UpdateRegistration {

    @InvocableMethod(callout=true)
    public static Response[] UpdateRegistration(Request[] inputList) {
        Response[] outputList = new Response[]{};
        Response output = new Response();
        try {
            for(Request input: inputList){
                //Integração getCadastro
                System.debug(input.matricula);
                Map<String,Object> returnCadastro = IntegrationUtils.getCadastro(input.matricula);                
                if(returnCadastro.get('statusCode') == 200){
                    IntegrationModels.CadastroResponse cad = (IntegrationModels.CadastroResponse) JSON.deserialize((String) returnCadastro.get('body'), IntegrationModels.CadastroResponse.class);
                    output.erro = cad?.erro;
                    if(cad?.erro == null){
                        output.nome = cad.cadastro.nome;
                        output.cpf = cad.cadastro.cpf;                        
                        //System.debug('cad >> ' + cad.cadastro.descCapacCivil);
                        //passar os outputs
                    }
                    
                }

                //Integração getEmail
                Map<String,Object> returnEmail = IntegrationUtils.getEmail(input.matricula);                
                if(returnEmail.get('statusCode') == 200){
                    IntegrationModels.Email em = (IntegrationModels.Email) JSON.deserialize((String) returnEmail.get('body'), IntegrationModels.Email.class);
                    output.email = em.email; 
                    System.debug(output.email);                
                }

                //Integração getEndereço
                Map<String,Object> returnEndereco = IntegrationUtils.getEndereco(input.matricula);
                if(returnEndereco.get('statusCode') == 200){
                    List<IntegrationModels.Enderecos> listEnde = new List<IntegrationModels.Enderecos>();
                    IntegrationModels.Enderecos ende = (IntegrationModels.Enderecos) JSON.deserialize((String) returnEndereco.get('body'), IntegrationModels.Enderecos.class);
                    System.debug('ende >> ' + ende);
                    listEnde.add(ende);
                    //colocar outputs
                    //System.debug(ende.enderecos[0].endereco);
                }

                //Integração getOpcoesCorrespondencia
                Map<String,Object> returnOpCorresp = IntegrationUtils.getOpcoesCorrespondencia(input.matricula);
                if(returnOpCorresp.get('statusCode') == 200){
                    List<IntegrationModels.ListOpcoesCorrespondencia> listOpcoes = new List<IntegrationModels.ListOpcoesCorrespondencia>();
                    IntegrationModels.ListOpcoesCorrespondencia opcoes = (IntegrationModels.ListOpcoesCorrespondencia) JSON.deserialize((String) returnOpCorresp.get('body'), IntegrationModels.ListOpcoesCorrespondencia.class);
                    listOpcoes.add(opcoes);
                    //System.debug(opcoes.opcoesCorrespondencia[0].envioEmail);}
                    //colocar outputs   
                }
            }
            outputList.add(output);
        }catch(Exception e) {
           System.debug(e); 
        }
        System.debug('return >> ' + outputList);
        return outputList;
    }

    public class Response{
        @InvocableVariable(label = 'Email')
        public String email;

        @InvocableVariable(label = 'Nome')
        public String nome;

        @InvocableVariable(label = 'CPF')
        public String cpf;

        @InvocableVariable(label = 'ERRO')
        public String erro;
    }

    public class Request{
        @InvocableVariable(label = 'Matrícula')
        public String matricula;
    }
}