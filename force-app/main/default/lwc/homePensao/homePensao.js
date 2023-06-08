import {
    LightningElement, track, api } from 'lwc';

import getRegistration from '@salesforce/apex/IntegrationESController.getRegistration';
import getPensoes from '@salesforce/apex/IntegrationPensaoController.getPensoes';
import getGruposFamiliar from '@salesforce/apex/IntegrationPensaoController.getGruposFamiliar';
import getPensionistas from '@salesforce/apex/IntegrationPensaoController.getPensionistas';
import getComplementoPensao from '@salesforce/apex/IntegrationPensaoController.getComplementoPensao';
import getRepresentanteLegal from '@salesforce/apex/IntegrationPensaoController.getRepresentanteLegal';
import getHistoricos from '@salesforce/apex/IntegrationPensaoController.getHistoricos';
import getHistoricoBilhetes from '@salesforce/apex/IntegrationPensaoController.getHistoricoBilhetes';
import getHistoricoBases from '@salesforce/apex/IntegrationPensaoController.getHistoricoBases';

const columns = [
    { label: 'Data do falecimento', fieldName: 'dtAusen',hideDefaultActions: true },
    { label: 'Data da Ausência', fieldName: 'dtAusen',hideDefaultActions: true },
    { label: 'Vinc. Previd', fieldName: 'vincPrevi',hideDefaultActions: true },
];

export default class HomePensao extends LightningElement {
    columns = columns;
    @track isModalOpen = false;
    @track isPopup = false;
    isCond = false;
    isAuditoria = false;
    isModalLegalRepresentative = false;
    isModalHistoric = false;
    isModalTicketHistory = false;
    isModalBaseHistory = false;
    loaded = false;
    loadedTicketHistory = false;
    loadedBaseHistory = false;
    loadedPensioner = false;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    @api recordId;
    @api initialise;

    @api pensaoList = [];
    @api pensionistaList = [];
    @api gruposFamiliarList = [];
    @api representanteLegalList = [];
    @api historicoList = [];
    @api historicoBilhetesList = [];
    @api historicoBasesList = [];
    @api complePensaoList = [];
    @api matricula;
    @api matriculaFuturo;
    @api matriculaRepresentante;
    @track error;
    listPensaoCabecalho = [];
    listPrevi = [];
    listINSSFuturo = [];
    listPreviFuturo = [];
    listINSS = [];
    listRepresentanteLegal = [];
    listHistorico = [];
    listHistoricoBilhetes = [];
    listHistoricoBases = [];
    @track listPensionistaCabecalho = [];
    listGrupos = [];
    listComplePensaoCabecalho = [];
    idPensionista = 0;
    historicoBilhetesAnt19112008 = '';

    initialiseData = [];

    connectedCallback() {
        //this.isModalOpen = true;
        this.getMatricula();
    }

    getMatricula() {
        getRegistration({ recordId : this.recordId })
            .then(result => {        
                if (result != '') {
                    //this.matricula = result;
                    this.matricula = '3328440';
                    this.matriculaFuturo = '4811184';
                    this.initialiseComponentPlano1(this.matricula);
                    this.initialiseComponentPreviFuturo(this.matriculaFuturo);
                }
            })
            .catch((error) => {
                console.log('error', error);
            });
    }

    initialiseComponentPlano1(mat) {
        getPensoes({ matricula: mat })
            .then(result => {
                console.log('entrou');
                console.log('result'+result);
                this.pensaoList = result;
                if (this.pensaoList != null){
                    console.log('this.pensaoList ' + JSON.stringify(this.pensaoList));
                    
                    for (let item in this.pensaoList) {
                        this.listPensaoCabecalho.push({     
                            dtAusen: this.pensaoList[item].dtAusen,                  
                            vincPrevi : this.pensaoList[item].vincPrevi
                        });
                    }

                    for (let item in this.pensaoList) {
                        this.listPrevi.push({     
                            especiePrevi: this.pensaoList[item].especiePrevi,              
                            dibPrevi : this.pensaoList[item].dibPrevi,
                            complPrevi : this.pensaoList[item].complPrevi,
                            complAdicBb : this.pensaoList[item].complAdicBb,
                            espec : this.pensaoList[item].espec,
                            cAlimen : this.pensaoList[item].cAlimen,
                            situacao : this.pensaoList[item].situacao,
                            dtSituac : this.pensaoList[item].dtSituac,
                            percPrevi : this.pensaoList[item].percPrevi,
                            encBenef : this.pensaoList[item].encBenef,
                            enc13 : this.pensaoList[item].enc13
                        });
                    }

                    console.log('this.listPrevi ' + JSON.stringify(this.listPrevi));

                    for (let item in this.pensaoList) {
                        this.listINSS.push({     
                            especieInss: this.pensaoList[item].especieInss,                  
                            dibInss : this.pensaoList[item].dibInss,
                            rmi : this.pensaoList[item].rmi,
                            percInss : this.pensaoList[item].percInss
                        });
                    }

                    console.log('this.listINSS ' + JSON.stringify(this.listINSS));

                    console.log('listPensaoCabecalho ', this.listPensaoCabecalho);
                    this.loaded = true;
                    this.getGruposFamiliar(this.matricula);
                    this.getRepresentanteLegal('9503440', '2');
                    this.getHistoricos('9503440', '1', '170306');
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    initialiseComponentPreviFuturo(mat) {
        getComplementoPensao({ matricula: mat })
            .then(result => {
                console.log('entrou complemento');
                console.log('result'+result);
                this.complePensaoList = result;
                if (this.complePensaoList != null){
                    console.log('this.complePensaoList ' + JSON.stringify(this.complePensaoList));
                    
                    for (let item in this.complePensaoList) {
                        this.listComplePensaoCabecalho.push({     
                            dtAusen: this.complePensaoList[item].dtAusen,                  
                            vincPrevi : this.complePensaoList[item].vincPrevi
                        });
                    }

                    for (let item in this.complePensaoList) {
                        this.listPreviFuturo.push({     
                            especiePrevi: this.complePensaoList[item].especiePrevi,              
                            dibPrevi : this.complePensaoList[item].dibPrevi,
                            complPrevi : this.complePensaoList[item].complPrevi,
                            complAdicBb : this.complePensaoList[item].complAdicBb,
                            espec : this.complePensaoList[item].espec,
                            cAlimen : this.complePensaoList[item].cAlimen,
                            situacao : this.complePensaoList[item].situacao,
                            dtSituac : this.complePensaoList[item].dtSituac,
                            percPrevi : this.complePensaoList[item].percPrevi,
                            encBenef : this.complePensaoList[item].encBenef,
                            enc13 : this.complePensaoList[item].enc13
                        });
                    }

                    console.log('this.listPreviFuturo ' + JSON.stringify(this.listPreviFuturo));

                    for (let item in this.complePensaoList) {
                        this.listINSSFuturo.push({     
                            especieInss: this.complePensaoList[item].especieInss,                  
                            dibInss : this.complePensaoList[item].dibInss,
                            rmi : this.complePensaoList[item].rmi,
                            percInss : this.complePensaoList[item].percInss
                        });
                    }

                    console.log('this.listINSSFuturo ' + JSON.stringify(this.listINSSFuturo));

                    console.log('listComplePensaoCabecalho ', this.listComplePensaoCabecalho);
                    this.loaded = true;
                    //this.getGruposFamiliar(this.matricula);
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    getGruposFamiliar(mat){
        getGruposFamiliar({ matricula: mat})
            .then(result => {
                console.log('entrou grupos familiar');
                console.log('result'+result);
                this.gruposFamiliar = result;
                if (this.gruposFamiliar != null){
                    console.log('this.gruposFamiliar ' + JSON.stringify(this.gruposFamiliar));
                    
                    for (let item in this.gruposFamiliar) {
                        if (this.gruposFamiliar[item].grupo != null){
                            this.getPensionistas(this.matricula, this.gruposFamiliar[item].grupo);
                        }
                    }

                    this.loaded = true;
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    getPensionistas(mat, grupo){
        getPensionistas({ matricula: mat, grupo: grupo })
            .then(result => {
                console.log('entrou pensionistas');
                console.log('entrou pensionistas'+grupo);
                console.log('result'+result);
                this.pensionistaList = result;
                if (this.pensionistaList != null){
                    console.log('this.pensionistaList ' + JSON.stringify(this.pensionistaList));
                    
                    for (let item in this.pensionistaList) {
                        this.listPensionistaCabecalho.push({    
                            id: this.idPensionista++,
                            nome: this.pensionistaList[item].nome,                  
                            vinculo : this.pensionistaList[item].vinculo,
                            situacao : this.pensionistaList[item].situacao,
                            dtSituacao : this.pensionistaList[item].dtSituacao,
                            grupo : this.pensionistaList[item].grupo,
                            areDetailsVisible : false,
                            dtInic : this.pensionistaList[item].dtInic,
                            dtRequer : this.pensionistaList[item].dtRequer,
                            situac : this.pensionistaList[item].situac,
                            dtSituac : this.pensionistaList[item].dtSituac,
                            observacao : this.pensionistaList[item].observacao,
                            numInss : this.pensionistaList[item].numInss,
                            represLegal : this.pensionistaList[item].represLegal,
                            sexo : this.pensionistaList[item].sexo,
                            estCiv : this.pensionistaList[item].estCiv,
                            dtNasc : this.pensionistaList[item].dtNasc,
                            invalidez : this.pensionistaList[item].invalidez,
                            titular : this.pensionistaList[item].titular,
                            cpf : this.pensionistaList[item].cpf,
                            dtInicPrevi : this.pensionistaList[item].dtInicPrevi,
                            dtInicInss : this.pensionistaList[item].dtInicInss,
                            motivoSituac : this.pensionistaList[item].motivoSituac,
                            suspensaoDataPrevi : this.pensionistaList[item].suspensaoDataPrevi,
                            cotaResguardadaPrevi : this.pensionistaList[item].cotaResguardadaPrevi,
                            cotaResguardadaInss : this.pensionistaList[item].cotaResguardadaInss,
                            percPrevi : this.pensionistaList[item].percPrevi,
                            percInss : this.pensionistaList[item].percInss,
                            fontePgtoPrevi : this.pensionistaList[item].fontePgtoPrevi,
                            fontePgtoInss : this.pensionistaList[item].fontePgtoInss,
                            fontePgtoBB : this.pensionistaList[item].fontePgtoBB
                        });
                    }

                    console.log('listPensionistaCabecalho ', this.listPensionistaCabecalho);
                }
                this.loadedPensioner = true;
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    getRepresentanteLegal(mat, grupo){
        getRepresentanteLegal({ matricula: mat, grupo: grupo })
            .then(result => {
                console.log('result'+result);
                this.representanteLegalList = result;
                if (this.representanteLegalList != null){
                    console.log('this.representanteLegalList ' + JSON.stringify(this.representanteLegalList));
                    
                    for (let item in this.representanteLegalList) {
                        this.listRepresentanteLegal.push({
                            nome: this.representanteLegalList[item].nome,                  
                            vinculo : this.representanteLegalList[item].cpf,
                            endereco : this.representanteLegalList[item].endereco,
                            cep : this.representanteLegalList[item].cep,
                            bairro : this.representanteLegalList[item].bairro,
                            municipio : this.representanteLegalList[item].municipio,
                            uf : this.representanteLegalList[item].uf,
                            email : this.representanteLegalList[item].email,
                            celuar : this.representanteLegalList[item].celular,
                            ddd : this.representanteLegalList[item].ddd,
                            telefone : this.representanteLegalList[item].telefone,
                            vigenciaIni : this.representanteLegalList[item].vigenciaIni,
                            vigenciaFim : this.representanteLegalList[item].vigenciaFim,
                            capacCivil : this.representanteLegalList[item].capacCivil,
                            tipoDoc : this.representanteLegalList[item].tipoDoc
                        });
                    }

                    console.log('listRepresentanteLegal ', this.listRepresentanteLegal);
                    this.loaded = true;
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    getHistoricos(mat, grupo, pensionista){
        getHistoricos({ matricula: mat, grupo: grupo, pensionista: pensionista })
            .then(result => {
                console.log('result'+result);
                this.historicoList = result;
                if (this.historicoList != null){
                    console.log('this.historicoList ' + JSON.stringify(this.historicoList));
                    
                    for (let item in this.historicoList) {
                        this.listHistorico.push({
                            dataInicio: this.historicoList[item].dataInicio,                  
                            dataFim : this.historicoList[item].dataFim,
                            inssPercent : this.historicoList[item].inssPercent,
                            previPercent : this.historicoList[item].previPercent,
                            bb : this.historicoList[item].bb,
                            inss : this.historicoList[item].inss,
                            previ : this.historicoList[item].previ
                        });
                    }

                    console.log('listHistorico ', this.listHistorico);
                    this.loaded = true;
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    getHistoricoBilhetes(mat){
        getHistoricoBilhetes({ matricula: mat})
            .then(result => {
                console.log('result'+result);
                this.historicoBilhetesList = result;
                if (this.historicoBilhetesList != null){
                    console.log('this.historicoBilhetesList ' + JSON.stringify(this.historicoBilhetesList));
                    this.historicoBilhetesAnt19112008 = this.historicoBilhetesList.ant19112008;
                    for (let item in this.historicoBilhetesList.consulta_historico_bilhete) {
                        this.listHistoricoBilhetes.push({
                            tipo: this.historicoBilhetesList.consulta_historico_bilhete[item].tipo,                  
                            dataFopag : this.historicoBilhetesList.consulta_historico_bilhete[item].dataFopag,
                            dataRecalculo : this.historicoBilhetesList.consulta_historico_bilhete[item].dataRecalculo,
                            descricao : this.historicoBilhetesList.consulta_historico_bilhete[item].descricao
                        });
                    }

                    console.log('listHistoricoBilhetes ', this.listHistoricoBilhetes);
                }
                this.loadedTicketHistory = true;
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    getHistoricoBases(mat){
        getHistoricoBases({ matricula: mat})
            .then(result => {
                console.log('result'+result);
                this.historicoBasesList = result;
                if (this.historicoBasesList != null){
                    console.log('this.historicoBasesList ' + JSON.stringify(this.historicoBasesList));
                    for (let item in this.historicoBasesList) {
                        this.listHistoricoBases.push({
                            dataCompetencia: this.historicoBasesList[item].dataCompetencia,                  
                            dataFopag : this.historicoBasesList[item].dataFopag,
                            valorInss : this.historicoBasesList[item].valorInss,
                            complPrevi : this.historicoBasesList[item].complPrevi,
                            total : this.historicoBasesList[item].total,
                        });
                    }

                    console.log('listHistoricoBases ', this.listHistoricoBases);
                    this.loadedBaseHistory = true;
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    toggleSection(event) {
        let buttonid = event.currentTarget.dataset.buttonid;
        let currentsection = this.template.querySelector('[data-id="' + buttonid + '"]');
        if (currentsection.className.search('slds-is-open') == -1) {
            currentsection.className = 'slds-section slds-is-open';
        } else {
            currentsection.className = 'slds-section slds-is-close';
        }
    }

    handleDetailsFromPensioner(evt){
        if (this.listPensionistaCabecalho[parseInt(evt.currentTarget.dataset.index, 10)].areDetailsVisible==false){
            this.listPensionistaCabecalho[parseInt(evt.currentTarget.dataset.index, 10)].areDetailsVisible = true;
        }else{
            this.listPensionistaCabecalho[parseInt(evt.currentTarget.dataset.index, 10)].areDetailsVisible = false;
        }
    }

    openModal(){
        this.isModalOpen = true;
    }

    openModalLegalRepresentative(){
        this.isModalLegalRepresentative = true;
    }

    openModalHistoric(){
        this.isModalHistoric = true;
    }

    openModalTicketHistory(){
        this.isModalTicketHistory = true;
        if (this.historicoBilhetesList.length===0){
            this.getHistoricoBilhetes('3328440');
        }
    }

    openModalBaseHistory(){
        this.isModalBaseHistory = true;
        if (this.historicoBasesList.length===0){
            this.getHistoricoBases('2078700');
        }
    }

    openModalCond() {
        // to open modal set isModalOpen tarck value as true
        this.isPopup = true;
        this.isCond = true;
        this.isAuditoria = false;
    }

    openModalAud() {
        // to open modal set isModalOpen tarck value as true
        this.isPopup = true;
        this.isAuditoria = true;
        this.isCond = false;
    }
    
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalLegalRepresentative = false;
        this.isModalHistoric = false;
        this.isModalTicketHistory = false;
        this.isModalBaseHistory = false;
        this.isCond = false;
        this.isAuditoria = false;
        this.isModalOpen = false;
        this.isPopup = false;     
    }
}