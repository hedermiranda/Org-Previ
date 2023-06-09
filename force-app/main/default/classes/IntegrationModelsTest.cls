@isTest
public class IntegrationModelsTest {
	@isTest
    static void getCadastrosTest(){
        IntegrationModels.GetCadastros getCadastros = new IntegrationModels.GetCadastros();
        getCadastros.nome = 'nameTeste'; 
        getCadastros.dataNascimento = 'Teste';
        getCadastros.sexo = 'Teste';
        getCadastros.tipoCliente = 'Teste';
        getCadastros.matricula = 1;
        getCadastros.codPlano = 1;
        getCadastros.codSituacaoEmpresa = 1;
        getCadastros.situacaoEmpresa = 'Teste';
        getCadastros.situacaoPrevi = 'Teste'; 
        getCadastros.statusPrevi = 'Teste';
        getCadastros.codEmpresa = 1;
        getCadastros.nomeEmpresa = 'Teste';
        getCadastros.numSeqPrevi = 1;
        getCadastros.email = 'Teste';
        getCadastros.cpf = 'Teste';       
        getCadastros.estadoCivil = 'Teste';
        getCadastros.idEstadoCivil = 1;
        getCadastros.tipo = 'Teste';
        getCadastros.codigoNumero = 'Teste';
        getCadastros.emissao = 'Teste';
        getCadastros.orgaoEmissor = 'Teste';
        getCadastros.pisPasep = 'Teste';
        getCadastros.pai = 'Teste';
        getCadastros.mae = 'Teste';
        getCadastros.nacionalidade = 'Teste';
        getCadastros.naturalidade = 'Teste';
        getCadastros.capacCivil = 1;
        getCadastros.descCapacCivil = 'Teste';
        
        IntegrationModels.CadastroResponse cadastroResponse = new IntegrationModels.CadastroResponse();
        cadastroResponse.cadastro = getCadastros;
    }
    
    @isTest
    static void endereco(){
        IntegrationModels.Endereco endereco = new IntegrationModels.Endereco();
        endereco.endereco = 'Teste';
        endereco.cep = 'Teste';
        endereco.bairro = 'Teste';
        endereco.idPais = 1.0;
        endereco.uf = 'Teste';
        endereco.idMunicipio = 1.0;
        endereco.email = 'Teste';
		List<IntegrationModels.Endereco> listEnd = new List<IntegrationModels.Endereco>();
        listEnd.add(endereco);
        
        IntegrationModels.Enderecos ende = new IntegrationModels.Enderecos();
        ende.enderecos=listEnd;
    }
    
    @isTest
    static void email(){
        IntegrationModels.Email email = new IntegrationModels.Email();
        email.email = 'Teste';
    }
    
    @isTest
    static void dadosBancarios(){
        IntegrationModels.DadosBancarios dadosBancarios = new IntegrationModels.DadosBancarios();
        dadosBancarios.agencia = 1;
        dadosBancarios.agenciaDV = 1;
        dadosBancarios.contaCorrente = 1;
        dadosBancarios.contaCorrenteDV = 1;
    }
    
    @isTest
    static IntegrationModels.Telefone telefone(){
        IntegrationModels.Telefone telefone = new IntegrationModels.Telefone();
        telefone.ddi = 'Teste';
        telefone.ddd = 'Teste';
        telefone.telefone = 'Teste';
        telefone.ramal = 'Teste';
        telefone.fax = 'Teste';
        return telefone;
    }
    
    @isTest
    static void opcoesCorrespondencia(){
        IntegrationModels.OpcoesCorrespondencia opcoesCorrespondencia = new IntegrationModels.OpcoesCorrespondencia();
        opcoesCorrespondencia.idCorrespondencia = 1.0;
        opcoesCorrespondencia.correspondencia = 'Teste';
        opcoesCorrespondencia.envioPostal = 'Teste';
        opcoesCorrespondencia.envioEmail = 'Teste';
        opcoesCorrespondencia.envioCelular = 'Teste';
        
        List<IntegrationModels.OpcoesCorrespondencia> listOp = new List<IntegrationModels.OpcoesCorrespondencia>();
        listOp.add(opcoesCorrespondencia);
        
        IntegrationModels.ListOpcoesCorrespondencia listOpcoesCorrespondencia = new IntegrationModels.ListOpcoesCorrespondencia();
        listOpcoesCorrespondencia.opcoesCorrespondencia = listOp;
    }
    
    @isTest
    static IntegrationModels.EnderecoAtualizar enderecoAtualizar(){
        IntegrationModels.EnderecoAtualizar enderecoAtualizar = new IntegrationModels.EnderecoAtualizar();
        enderecoAtualizar.logradouro = 'Teste';
        enderecoAtualizar.numero = '1';
        enderecoAtualizar.complemento = 'Teste';
        enderecoAtualizar.bairro = 'Teste';
        enderecoAtualizar.municipio = 'Teste';
        enderecoAtualizar.uf = 'Teste';
        enderecoAtualizar.cep = 'Teste';
        enderecoAtualizar.pais = 'Teste';
        return enderecoAtualizar;
    }
    
    @isTest
    static void PUTatualizarEndereco(){
        IntegrationModels.AtualizarEndereco atualizarEndereco = new IntegrationModels.AtualizarEndereco();
        //public IntegrationModels.EnderecoAtualizar[] atualizar {get;set;}
        List<IntegrationModels.EnderecoAtualizar> listAtualizar = new List<IntegrationModels.EnderecoAtualizar>();
        IntegrationModels.EnderecoAtualizar ende = IntegrationModelsTest.enderecoAtualizar();
        listAtualizar.add(ende);
        atualizarEndereco.atualizar = ende;
        atualizarEndereco.idMatricula = 1;
    }
    
    @isTest
    static void cadastroGecat(){
        IntegrationModels.CadastroGecat cadastroGecat = new IntegrationModels.CadastroGecat();
        cadastroGecat.idPais = 1;
        cadastroGecat.cep = 'Teste';
        cadastroGecat.logradouro = 'Teste';
        cadastroGecat.idMunicipio = 'Teste';
        cadastroGecat.municipio = 'Teste';
        cadastroGecat.bairro = 'Teste';
        cadastroGecat.email = 'Teste';
        IntegrationModels.Telefone tel = IntegrationModelsTest.telefone();
        List<IntegrationModels.Telefone> listTel = new List<IntegrationModels.Telefone>();
        listTel.add(tel);
        cadastroGecat.telefone = listTel;
    }
}