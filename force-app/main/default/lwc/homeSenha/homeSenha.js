import {
    LightningElement, track, api } from 'lwc';

import getHistoricosSenha from '@salesforce/apex/IntegrationSenhaController.getHistoricosSenha';
import getSolicitacoesTroca from '@salesforce/apex/IntegrationSenhaController.getSolicitacoesTroca';

export default class HomeSenha extends LightningElement {
    isModalAlterarSenha = false;
    isModalConsultarAlteracoes = false;
    loaded = false;
    loadedAlterarSenha = true;
    loadedConsultarAlteracoes = true;
    areDetailsVisible = false;
    historicosSenha = [];
    senhaHistoricos = [];
    solicitacoesTrocaSenha = [];
    senhaSolicitacoesTroca = [];
    ultDataFim = '1900-01-01 00:00:00';
    ultMotivo = '';

    connectedCallback() {
        //this.getHistoricosSenha('8028614');
        //this.getSolicitacoesTroca('8028614');
    }

    getHistoricosSenha(mat){
        getHistoricosSenha({ matricula: mat})
            .then(result => {
                //console.log('result'+result);
                this.historicosSenha = result;
                if (this.historicosSenha != null){
                    //console.log('this.historicosSenha ' + JSON.stringify(this.historicosSenha));
                    
                    for (let item in this.historicosSenha) {
                        if (this.ultDataFim < this.historicosSenha[item].dataFim){
                            this.ultDataFim = this.historicosSenha[item].dataFim;
                            this.ultMotivo = this.historicosSenha[item].motivo;
                        }

                        this.senhaHistoricos.push({
                            dataSolicitacao: this.historicosSenha[item].dataSolicitacao,                  
                            dataInicio : this.historicosSenha[item].dataInicio,
                            dataFim : this.historicosSenha[item].dataFim,
                            motivo : this.historicosSenha[item].motivo
                        });
                    }

                    this.loaded = true;
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    getSolicitacoesTroca(mat){
        getSolicitacoesTroca({ matricula: mat})
            .then(result => {
                //console.log('result'+result);
                this.solicitacoesTrocaSenha = result;
                if (this.solicitacoesTrocaSenha != null){
                    console.log('this.solicitacoesTrocaSenha ' + JSON.stringify(this.solicitacoesTrocaSenha));
                    for (let item in this.solicitacoesTrocaSenha) {
                        this.senhaSolicitacoesTroca.push({
                            dataAutorizacao: this.solicitacoesTrocaSenha[item].dataAutorizacao,                  
                            nomeUsuarioInclusao : this.solicitacoesTrocaSenha[item].nomeUsuarioInclusao,
                            nomeUsuarioAutorizacao : this.solicitacoesTrocaSenha[item].nomeUsuarioAutorizacao,
                            indAlteracaoConcluida : this.solicitacoesTrocaSenha[item].indAlteracaoConcluida
                        });
                    }
                    this.loaded = true;
                    
                }
            })
            .catch(error => {
                console.log('error', error);
            });
    }

    openModalAlterarSenha(){
        this.isModalAlterarSenha = true;
    }

    openModalConsultarAlteracoes(){
        this.isModalConsultarAlteracoes = true;
    }

    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalAlterarSenha = false;
        this.isModalConsultarAlteracoes = false;
    }

    handleDetailsFromHistoric(){
        if (this.areDetailsVisible == true){
            this.areDetailsVisible = false;
        }else{
            this.areDetailsVisible = true;
        }        
    }
}