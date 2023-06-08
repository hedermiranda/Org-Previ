import { LightningElement, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getHistEmail from '@salesforce/apex/HistoricosController.getHistEmail';

const columns = [
    { label: 'Data Log', fieldName: 'dataLog',hideDefaultActions: true },
    { label: 'Usuário', fieldName: 'UsuarioInclusao',hideDefaultActions: true },
    { label: 'E-mail', fieldName: 'endEmail',hideDefaultActions: true },
];

export default class HistEmails extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    
    @api matricula
    
    listEmails = [];

    connectedCallback() {
        console.log('Entrou callback EMAILS');
        this.loadingEmails();  
    }

    loadingEmails() {
        console.log('Entrou loadingEmails com a matricula >>' + this.matricula);
        getHistEmail({ matricula: this.matricula})
            .then(result => {
                console.log('RESULT >> ' + JSON.stringify(result));
                if (result != null) {

                    let returnEmails = [];
                    result.forEach(rec => {
                        let record = {};
                        record.dataLog = rec.dataLog;
                        record.UsuarioInclusao = rec.UsuarioInclusao;
                        record.endEmail = rec.endEmail;

                        returnEmails.push(record);
                    })
                    
                    this.listEmails = returnEmails;
                    
                    console.log('returnEmails >> ' + JSON.stringify(returnEmails));
                    console.log('this.listEmails >> ' + JSON.stringify(this.listEmails));
                } else {
                    this.texto = 'Não há histórico de EMAILS para essa matrícula!';
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
        const cloneData = [...this.listEmails];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.listEmails = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }
}