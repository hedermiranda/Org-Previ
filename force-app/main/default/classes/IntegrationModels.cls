/****************************************************************************
*                               ília - 2022
*----------------------------------------------------------------------------
*
* Classe para modelagem de objetos de integrações
*
* NAME: IntegrationModels.apxc
* DATE: 25/09/2022
*****************************************************************************/
@suppresssWarnings('pmd.ExcessivePublicCount')
public with sharing class IntegrationModels{

    //DADOS CADASTRAIS REQUEST - BEGIN ******************************
    public class CadastroResponse{
       public GetCadastros cadastro {get;set;}
       public String erro {get;set;}
    }

    //PUT ENDEREÇOS
    public class AtualizarEndereco{
        public IntegrationModels.EnderecoAtualizar atualizar {get;set;}
        public Integer idMatricula {get;set;}
    } 

    public class GetCadastros{                
        public String nome {get;set;}
        public String dataNascimento {get;set;} //rever date
        public String sexo {get;set;}
        public String tipoCliente {get;set;}
        public Integer matricula {get;set;}  
        public Integer codPlano {get;set;}
        public Integer codSituacaoEmpresa {get;set;}
        public String situacaoEmpresa {get;set;}
        public String situacaoPrevi {get;set;}
        public String statusPrevi {get;set;}
        public Integer codEmpresa {get;set;}
        public String nomeEmpresa {get;set;}
        public Integer numSeqPrevi {get;set;}
        public String email {get;set;}
        public String cpf {get;set;}         
        public String estadoCivil {get;set;}
        public Integer idEstadoCivil {get;set;}
        public String tipo {get;set;}
        public String codigoNumero {get;set;}
        public String emissao {get;set;} //rever date
        public String orgaoEmissor {get;set;}
        public String pisPasep {get;set;}
        public String pai {get;set;}
        public String mae {get;set;}
        public String nacionalidade {get;set;}
        public String naturalidade {get;set;}
        public Integer capacCivil {get;set;}
        public String descCapacCivil {get;set;}
        public String erro {get;set;}
    }

    public class Enderecos{
        public List<Endereco> enderecos {get;set;}
        
    }
    public class Endereco{
        public String endereco {get;set;}
        public String cep {get;set;}
        public String bairro {get;set;}
        public Double idPais {get;set;}
        public String uf {get;set;}
        public Double idMunicipio {get;set;}
        public String email {get;set;}
    }

    public class Municipios{
        public List<Municipio> municipiosBR {get;set;}
    }

    public class Municipio{
        public Integer idMunicipio {get;set;}
        public String municipio {get;set;}
        public String uf {get;set;}
    }
    public class Email{
        public String email {get;set;}
    }

    public class DadosBancarios{
        public Integer agencia {get;set;}
        public Integer agenciaDV {get;set;}
        public Integer contaCorrente {get;set;}
        public Integer contaCorrenteDV {get;set;}
    }

    //Classe utilizada para o método PUT - Atualização ou insert de registro no legado
    
    public class PutTelefone{
        public String ddd1 {get;set;}
        public String ddd2 {get;set;}
        public String ddd3 {get;set;}
        public String ddd4 {get;set;}
        public String ddi1 {get;set;}
        public String ddi2 {get;set;}
        public String ddi3 {get;set;}
        public String ddi4 {get;set;}
        public String telefone1 {get;set;}
        public String telefone2 {get;set;}
        public String telefone3 {get;set;}
        public String ramal1 {get;set;}
        public String ramal2 {get;set;}
        public String ramal3 {get;set;}
        public String fax {get;set;}
        //public integer idMatricula {get;set;}
    }
	
    public class ListOpcoesCorrespondencia{
        public List<OpcoesCorrespondencia> opcoesCorrespondencia {get;set;}
    }
    // Método para montar o POST das opções de correspondência 
    public class OpcoesCorrespondencia{
        public Double idCorrespondencia {get;set;}
        public String correspondencia {get;set;}
        public String envioPostal {get;set;}
        public String envioEmail {get;set;}
        public String envioCelular {get;set;}
    }

    public class PostOpcoes{
        public Integer idCorrespondencia {get;set;}
        public String envioPostal {get;set;}
        public String envioEmail {get;set;}
        public String envioCelular {get;set;}
    }

   
    //Classe para método POST dos dados cadastrais dos participantes quando o tipo de relacionamento for GECAT
    public class CadastroGecat{
        public Integer idPais {get;set;}
        public String cep {get;set;}
        public String logradouro {get;set;}
        public String idMunicipio {get;set;}
        public String municipio {get;set;}
        public String bairro {get;set;}
        public String email {get;set;}
        public IntegrationModels.Telefone[] telefone {get;set;}
    }

    //Classe para método POST dos dados cadastrais dos participantes quando o tipo de relacionamento for CAPEC
    public class CadastroCapec{

    }

    //Classe para método POST dos dados cadastrais dos participantes quando o tipo de relacionamento for Benef
    public class CadastroBenef{

    }

    //Put para endereços - Não precisa mais usar o tipo de formulário. 
    //
    public class EnderecoAtualizar{
        public String logradouro {get;set;}
        public String numero {get;set;}
        public String complemento {get;set;}
        public String bairro {get;set;}
        public String municipio {get;set;}
        public String uf {get;set;}
        public String cep {get;set;}
        public String pais {get;set;}        
    }

    //GET TELEFONES
    public class Telefones{
        public List<Telefone> telefones {get;set;}
    }

    public class Telefone{
        public String ddi {get;set;}
        public String ddd {get;set;}
        public String telefone {get;set;}
        public String ramal {get;set;}
        public String fax {get;set;}
        public String tipo {get;set;}
    }
}