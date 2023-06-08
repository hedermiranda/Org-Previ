import { LightningElement, api } from 'lwc'; 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getHistSituacoesFuncionais from '@salesforce/apex/HistoricosController.getHistSituacoesFuncionais';

const columns = [
    { label: 'Código Situação', fieldName: 'codigoSituacao',hideDefaultActions: true },
    { label: 'Situação', fieldName: 'descricao',hideDefaultActions: true },
    { label: 'Data Início', fieldName: 'dataInicio',hideDefaultActions: true },
    { label: 'Data Fim', fieldName: 'dataFim',hideDefaultActions: true },
];

export default class HistSituFuncionais extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    @api matricula

    listSituFunc = [];

    connectedCallback() {
        console.log('Entrou callback SituFunc');
        this.loadingSituFunc();  
    }

    loadingSituFunc() {
        console.log('Entrou loadingSituFunc com a matricula >>' + this.matricula);
        getHistSituacoesFuncionais({ matricula: this.matricula})
            .then(result => {
                console.log('RESULT SITU FUNCIONAIS >> ' + JSON.stringify(result));
                if (JSON.stringify(result).length > 2) {

                    let returnSituFunc = [];
                    result.forEach(rec => { 
                        let record = {};
                        record.codigoSituacao = rec.codigoSituacao;
                        record.descricao = rec.descricao;
                        record.dataInicio = rec.dataInicio;
                        record.dataFim = rec.dataFim;

                        returnSituFunc.push(record);

                    })
                    
                    this.listSituFunc = returnSituFunc;
                    
                    console.log('returnSituFunc >> ' + JSON.stringify(returnSituFunc));
                    console.log('this.listSituFunc >> ' + JSON.stringify(this.listSituFunc));
                } else {
                    this.texto = 'Não há histórico de SITUAÇÕES FUNCIONAIS para essa matrícula!';
                }
                this.loading = false;
            })
            .catch(error => {
                this.loading = false;
                console.log('error ', error);
                this.showNotification('ERRO', error, 'error', 'sticky');                
            });
    }

    showNotification(title, message, variant, mode) {
        const msg = {
            title: title,
            message: message,
            variant: variant,
            mode: mode
        };
        const evt = new ShowToastEvent(msg);
        this.dispatchEvent(evt);
    }
}