import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getRecadastramento from '@salesforce/apex/IntegrationPensaoController.getRecadastramento';

export default class tabAposRecadastramento extends LightningElement {

    //TabAposRecadastramento

    loading = true;
    @api matricula
    recadastramentoList = [];
    listRecadastramento = [];
    options = [];
    valueYear;

    connectedCallback() {
        let currentTime = new Date();
        let year = currentTime.getFullYear();
        this.getOptions();
        this.getRecadastramento('721008', year.toString());
    }

    getOptions() {
        let currentTime = new Date();
        let year = currentTime.getFullYear();
        this.valueYear = year.toString();
        for (let i = year - 5; i <= year; i++) {
            this.options.push({
                label: i.toString(),
                value: i.toString()
            });
        }
    }

    getRecadastramento(mat, ano) {
        getRecadastramento({ matricula: mat, ano: ano })
            .then(result => {
                if (result != '') {
                    this.recadastramentoList = result;
                    if (this.recadastramentoList != null) {
                        //console.log('this.recadastramentoList ' + JSON.stringify(this.recadastramentoList));
                        this.listRecadastramento = this.recadastramentoList;
                    }
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