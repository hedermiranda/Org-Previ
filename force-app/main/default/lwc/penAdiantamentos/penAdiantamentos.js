import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getAdiantamentos from '@salesforce/apex/IntegrationPensaoController.getAdiantamentos';

export default class PenAdiantamentos extends LightningElement {
    loading = true;
    @api matricula
    adiantamentosList = [];
    listAdiantamentos = [];

    connectedCallback() {
        console.log('Entrou callback Adiantamentos');
        this.getAdiantamentos(this.matricula);    
    }

    getAdiantamentos(mat) {
        getAdiantamentos({ matricula : mat })
            .then(result => {        
                if (result != '') {
                    console.log('mat'+mat);
                    console.log('result'+result);
                    this.adiantamentosList = result;
                    if (this.adiantamentosList != null){
                        console.log('this.adiantamentosList ' + JSON.stringify(this.adiantamentosList));
                        
                        for (let item in this.adiantamentosList) {
                            this.listAdiantamentos.push({
                                fopag: this.adiantamentosList[item].fopag,                  
                                valorEspelho : this.adiantamentosList[item].valorEspelho,
                                dtCredito : this.adiantamentosList[item].dtCredito,
                                valorPrevi : this.adiantamentosList[item].valorPrevi,
                                valorInss : this.adiantamentosList[item].valorInss,
                                lancConfirmado : this.adiantamentosList[item].lancConfirmado,
                                tipoBeneficio : this.adiantamentosList[item].tipoBeneficio,
                                nome : this.adiantamentosList[item].nome,
                                agencia : this.adiantamentosList[item].agencia,
                                contaCorrente : this.adiantamentosList[item].contaCorrente,
                                valPreviLiq : this.adiantamentosList[item].valPreviLiq,
                                valInssLiq : this.adiantamentosList[item].valInssLiq
                            });  
                        }
                    }
                    console.log('listAdiantamentos ', this.listAdiantamentos);
                }
                this.loading = false;
            })
            .catch((error) => {
                console.log('error', error);
            });
    }
}