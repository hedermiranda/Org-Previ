import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getFuncoes from '@salesforce/apex/HistoricosController.getFuncoes';

const columns = [
    { label: 'Código Ocupação', fieldName: 'codOcupacao',hideDefaultActions: true },
    { label: 'Descrição Ocupação', fieldName: 'nomeOcupacao',hideDefaultActions: true },
    { label: 'Data Início', fieldName: 'dataIniVigenc',hideDefaultActions: true },
    { label: 'Data Fim', fieldName: 'dataFimVigenc',hideDefaultActions: true },
];

export default class HistFuncoes extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    
    @api matricula
    
    listFuncoes = [];

    connectedCallback() {
        console.log('Entrou callback FUNCOES');
        this.loadingFuncoes();  
    }

    loadingFuncoes() {
        console.log('Entrou loadingFuncoes com a matricula >>' + this.matricula);
        getFuncoes({ matricula: this.matricula})
            .then(result => {
                console.log('RESULT >> ' + JSON.stringify(result));
                if (result != null) {

                    let returnFuncoes = [];
                    result.forEach(rec => {
                        let record = {};
                        record.codOcupacao = rec.codOcupacao;
                        record.nomeOcupacao = rec.nomeOcupacao;
                        record.dataIniVigenc = rec.dataIniVigenc;
                        record.dataFimVigenc = rec.dataFimVigenc;

                        returnFuncoes.push(record);

                    })
                    
                    this.listFuncoes = returnFuncoes;
                    
                    console.log('returnFuncoes >> ' + JSON.stringify(returnFuncoes));
                    console.log('this.listFuncoes >> ' + JSON.stringify(this.listFuncoes));
                } else {
                    this.texto = 'Não há histórico de FUNÇÕES para essa matrícula!';
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

    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.listProtocolos];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.listProtocolos = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }
}