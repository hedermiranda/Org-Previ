@isTest
private class IntegrationPensaoControllerTest {
    
    @testSetup
    public static void setup(){
        Account Cadastro = createAccount('teste', '8196667418', 'email@teste', '1747575');
    }

    private static account createAccount(string name, string phone, String email, String registration){
        Account cadastro = new Account();
        cadastro.Name = name;
        cadastro.phone = phone;
        cadastro.Registration__c = registration;
        cadastro.Income_Tax_Statement__c = 'Postal';
        cadastro.Info_Previ__c = 'Email';
        cadastro.Other_Institutional_Info__c = 'Email';
        cadastro.Card_Benefits_Club__c = 'Email';
        cadastro.Other_Promotional_Info__c = 'Email';
        
        insert cadastro;
        return cadastro;        
    }

    @isTest static void getPensoes(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{"consulta_pensao_morte": [{"dtAusen": null,"vincPrevi": "INSS e PREVI","especiePrevi": "COMPLEMENTO PENSAO POR MORTE DE ATIVO","dibPrevi": "28/03/2021","situacao": "DEF","dtSituac": "28/03/2021","percPrevi": 90.00,"percInss": 100.00,"encBenef": "PREVI","enc13": "PREVI","espec": null,"especieInss": "PENSÃO POR MORTE","dibInss": "28/03/2021","dibInssAnt": null,"rmi": 1100.00,"complPrevi": 2338.89,"complAdicBb": null        }    ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getPensoes(conta.Registration__c) != null);
        Test.stopTest(); 
    }

    @isTest static void getHistoricoBilhetes(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "consulta_historico_bilhete": [ { "tipo": "MANUTENÇÃO", "dataFopag": "05/2013", "dataRecalculo": "01/01/2013", "descricao": "TESTE." }], "ant19112008": "TESTE"}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getHistoricoBilhetes(conta.Registration__c) != null);
        Test.stopTest(); 
    }

    @isTest static void getHistoricoBases(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "consulta_apose_hist_base": [ { "dataCompetencia": "06/1994", "dataFopag": "06/1994", "valorInss": 377.65, "complPrevi": 1807.13, "total": 2.18478E+3 } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getHistoricoBases(conta.Registration__c) != null);
        Test.stopTest(); 
    }

    @isTest static void getGruposFamiliar(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "grupo_Familiar": [ { "grupo": 1, "seqGrupo": 16302, "seqBenef": 102089, "situacao": "ENC" } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getGruposFamiliar(conta.Registration__c) != null);
        Test.stopTest(); 
    }

    @isTest static void getPensionistas(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "calcular_pensionista": [ { "grupo": 1, "dtInic": "24/04/2001", "dtRequer": "30/05/2001", "idPensionista": 102089, "situac": "ENC", "dtSituac": "24/06/2005", "observacao": "NOV/04 RECEBIDO RECADASTRAMENTO ASSINADO PELA PRÓPRIA.", "numInss": "119328345-8", "represLegal": "N", "nome": "MARIA LIMA MOTTA", "sexo": "F", "estCiv": "5", "dtNasc": "29/04/1918", "invalidez": "N", "titular": "S", "cpf": "315854468-74", "dtInicPrevi": "24/04/2001", "dtInicInss": "01/06/2001", "dtInicCassi": "24/04/2001", "situacao": "ENC", "dtSituacao": "24/06/2005", "motivoSituac": "MOR", "vinculo": "CÔNJUGE", "suspensaoDataPrevi": null, "cotaResguardadaPrevi": "N", "cotaResguardadaInss": "N", "percPrevi": 35.00, "percInss": 100.00000000, "fontePgtoPrevi": "S", "fontePgtoInss": "S", "fontePgtoBB": "N" } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getPensionistas(conta.Registration__c, '1') != null);
        Test.stopTest(); 
    }

    @isTest static void getRepresentanteLegal(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "recalc_pensao_individual": [ { "cpf": 31120949807, "nome": "EDNA APARECIDA FERRITE GORGULHO", "endereco": "AVENIDA PEDRO DE TOLEDO, 1042", "cep": 16370000, "bairro": "CENTRO", "municipio": "PROMISSAO", "uf": "SP", "email": "fabi.fgorgulho@live.com", "celular": null, "ddd": "014", "telefone": "35410112", "vigenciaIni": "2012-06-27 00:00:00", "vigenciaFim": null, "capacCivil": "INTERDITO", "tipoDoc": 1 } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getRepresentanteLegal(conta.Registration__c, '1') != null);
        Test.stopTest(); 
    }

    @isTest static void getHistoricos(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "historico_pensao_morte": [ { "dataInicio": "18/01/2015", "dataFim": "31/05/2015", "inssPercent": 100.00000000, "previPercent": 26.67, "bb": "N", "inss": "S", "previ": "S" }, { "dataInicio": "01/06/2015", "dataFim": "30/06/2015", "inssPercent": 33.33333333, "previPercent": 26.67, "bb": "N", "inss": "S", "previ": "S" }, { "dataInicio": "01/07/2015", "dataFim": null, "inssPercent": 33.33333333, "previPercent": 26.67, "bb": "N", "inss": "S", "previ": "S" } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getHistoricos(conta.Registration__c, '1', '170306') != null);
        Test.stopTest(); 
    }

    @isTest static void getComplementoPensao(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "consulta_comple_morte": [ { "dtAusen": null, "vincPrevi": "INSS e PREVI", "especiePrevi": "COMPLEMENTO PENSAO POR MORTE DE ATIVO", "dibPrevi": "28/03/2021", "situacao": "DEF", "dtSituac": "28/03/2021", "percPrevi": 90.00, "percInss": 100.00, "encBenef": "PREVI", "enc13": "PREVI", "espec": null, "especieInss": "PENSÃO POR MORTE", "dibInss": "28/03/2021", "dibInssAnt": null, "rmi": 1100.00, "complPrevi": 2338.89, "complAdicBb": null } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getComplementoPensao(conta.Registration__c) != null);
        Test.stopTest(); 
    }

    @isTest static void getPendenciaDocumentos(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "pendencia_documentos": [ { "descricao_doc": "teste", "data_cadastro": "2021-04-27 17:15:02" } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getPendenciaDocumentos(conta.Registration__c, '1', '170306') != null);
        Test.stopTest(); 
    }

    @isTest static void getConcessaoInssPrisma(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "concessao_inss_prisma": [ { "data": "12/06/2015", "descricao": "Indeferido em 09/06/2015 - Recebimento de outro benefício (NB 171.723.568-6)." }, { "data": "13/04/2015", "descricao": "Via GEPES BRASÍLIA II. Casamento realizado em 25/10/2006. * Originais já solicitados pela GEPES." }, { "data": "13/04/2015", "descricao": "Habilitado." }, { "data": "17/04/2015", "descricao": "Originais em 17/04/2015." }, { "data": "23/04/2015", "descricao": "Solicitado em 23/04/2015 CTPS." }, { "data": "04/05/2015", "descricao": "Recebemos no dia 30/04/2015: Declaração por escrito + RPO - Registro Policial de Ocorrência sobre o extravio da CTPS do segurado + CNIS." }, { "data": "13/05/2015", "descricao": "Processo encaminhado ao INSS" }, { "data": "14/05/2015", "descricao": "Correção da situação do NB" } ], "tipoBenef": "P", "especieNb": 21, "num_beneficio": "129142238-0", "dib": "15/03/2015", "nome": "JOSEFA MARIA CORREIA BARBOSA", "cpf": 31273565, "dv": 1, "vinculo": 30, "sexo": "F", "dataNasc": "23/08/1983", "tit": "S", "inv": "N", "rl": "N", "endereco": "RUA JOSÉ BRAULIO DE SOUZA", "numero": "244", "complemento": null, "bairro": "SUTI", "municipio": "TOBIAS BARRETO", "cep": "49300", "complCep": "000", "uf": "SE", "dd1": "079", "dd2": "079", "dd3": null, "tel1": 999264171, "tel2": 996455587, "tel3": null, "email": null}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getConcessaoInssPrisma(conta.Registration__c) != null);
        Test.stopTest(); 
    }

    @isTest static void getAdiantamentos(){ 
        Test.startTest();
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{ "consulta_hist_adiantamento": [ { "fopag": "01/03/2004", "valorEspelho": 5018.04, "dtCredito": "09/02/2004", "valorPrevi": 3010.82, "valorInss": null, "lancConfirmado": "Aceito Remessa", "tipoBeneficio": "PENSÃO", "nome": "CLAUDIO JOSE CARNEIRO DOS SANTOS", "agencia": 1509, "contaCorrente": 2078700, "valPreviLiq": null, "valInssLiq": null } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Account conta = [SELECT Id, Registration__c FROM Account LIMIT 1];  
        System.assert(IntegrationPensaoController.getAdiantamentos(conta.Registration__c) != null);
        Test.stopTest(); 
    }
}