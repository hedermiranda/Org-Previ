import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getLicencaInteresses from '@salesforce/apex/HistoricosController.getLicencaInteresses';

const columns = [
    { label: 'Data Início', fieldName: 'dataIniVigenc',hideDefaultActions: true },
    { label: 'Data Fim', fieldName: 'dataFimVigenc',hideDefaultActions: true },
    { label: 'Código', fieldName: 'codSituac',hideDefaultActions: true },
    { label: 'Nome', fieldName: 'nomSituac',hideDefaultActions: true },
];

export default class HistLicencasInteresses extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    
    @api matricula
    
    listLicInteresses = [];

    connectedCallback() {
        console.log('Entrou callback LICENÇA INTERESSE');
        this.loadingLicInteresses();  
    }

    loadingLicInteresses() {
        console.log('Entrou loadingLicInteresses com a matricula >>' + this.matricula);
        getLicencaInteresses({ matricula: this.matricula})
            .then(result => {
                console.log('RESULT >> ' + JSON.stringify(result));
                if (result != null) {

                    let returnLicInteresses = [];
                    result.forEach(rec => {
                        let record = {};
                        record.dataIniVigenc = rec.dataIniVigenc;
                        record.dataFimVigenc = rec.dataFimVigenc;
                        record.codSituac = rec.codSituac;
                        record.nomSituac = rec.nomSituac;

                        returnLicInteresses.push(record);

                    })
                    
                    this.listLicInteresses = returnLicInteresses;
                    
                    console.log('returnFuncoes >> ' + JSON.stringify(returnLicInteresses));
                    console.log('this.listLicInteresses >> ' + JSON.stringify(this.listLicInteresses));
                } else {
                    this.texto = 'Não há histórico de LICENÇA INTERESSE para essa matrícula!';
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