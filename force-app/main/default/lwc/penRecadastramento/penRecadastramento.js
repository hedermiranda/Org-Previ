import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getRecadastramento from '@salesforce/apex/IntegrationPensaoController.getRecadastramento';

export default class PenRecadastramento extends LightningElement {
    loading = true;
    @api matricula
    recadastramentoList = [];
    listRecadastramento = [];
    options = [];
    valueYear;

    connectedCallback() {
        let currentTime = new Date();
        let year = currentTime.getFullYear();
        console.log('Entrou callback Recadastramento');
        this.getOptions();
        this.getRecadastramento('721008', year.toString());
    }

    getOptions(){
        let currentTime = new Date();
        let year = currentTime.getFullYear();
        this.valueYear = year.toString();
        for (let i = year-5; i <= year; i++){
            this.options.push({
                label: i.toString(),
                value: i.toString()
            });
        }
    }

    getRecadastramento(mat, ano) {
        getRecadastramento({ matricula : mat, ano : ano })
            .then(result => {        
                if (result != '') {
                    console.log('mat'+mat);
                    console.log('result'+result);
                    this.recadastramentoList = result;
                    if (this.recadastramentoList != null){
                        console.log('this.recadastramentoList ' + JSON.stringify(this.recadastramentoList));
                        this.listRecadastramento = this.recadastramentoList;
                        /*for (let item in this.recadastramentoList) {
                            this.listRecadastramento.push({
                                idParticipante: this.recadastramentoList[item].idParticipante,                  
                                tipo : this.recadastramentoList[item].tipo,
                                descricao : this.recadastramentoList[item].descricao,
                                limitePrimeiraCarta : this.recadastramentoList[item].limitePrimeiraCarta,
                                limiteSegundaCarta : this.recadastramentoList[item].limiteSegundaCarta,
                                ano : this.recadastramentoList[item].ano,
                                dataRetorno : this.recadastramentoList[item].dataRetorno
                            });
                        }*/
                    }
                    console.log('listRecadastramento ', this.listRecadastramento);
                }
                this.loading = false;
            })
            .catch((error) => {
                console.log('error', error);
            });
    }

    handleChange(event) {
        this.valueYear = event.detail.value;
        this.listRecadastramento = [];
        this.getRecadastramento('721008', this.valueYear);
    }
}