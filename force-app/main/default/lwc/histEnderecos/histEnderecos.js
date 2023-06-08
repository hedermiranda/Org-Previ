import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getHistEnderecos from '@salesforce/apex/HistoricosController.getHistEnderecos';

const columns = [
    { label: 'Data log', fieldName: 'datLog',hideDefaultActions: true },
    { label: 'Usuário', fieldName: 'Usuario',hideDefaultActions: true },
    { label: 'Logradouro', fieldName: '',hideDefaultActions: true },
    { label: 'Bairro', fieldName: '',hideDefaultActions: true },
    { label: 'Município', fieldName: 'municipio',hideDefaultActions: true },
    { label: 'CEP', fieldName: '',hideDefaultActions: true },
    { label: 'UF', fieldName: 'estado',hideDefaultActions: true },
    { label: 'País', fieldName: 'pais',hideDefaultActions: true },
];

export default class HistEnderecos extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    
    @api matricula
    
    listEnderecos = [];

    connectedCallback() {
        console.log('Entrou callback ENDERECOS');
        this.loadingEnderecos();  
    }

    loadingEnderecos() {
        console.log('Entrou loadingEnderecos com a matricula >>' + this.matricula);
        getHistEnderecos({ matricula: this.matricula})
            .then(result => {
                console.log('RESULT >> ' + JSON.stringify(result));
                if (result != null) {

                    let returnEnderecos = [];
                    result.forEach(rec => {
                        let record = {};
                        record.datLog = rec.datLog;
                        record.Usuario = rec.Usuario;
                        record.nom_atrib = rec.nom_atrib;
                        record.val_atrib = rec.val_atrib;
                        record.municipio = rec.municipio;
                        record.estado = rec.estado;
                        record.pais = rec.pais;

                        returnEnderecos.push(record);
                    })
                    
                    this.listEnderecos = returnEnderecos;
                    
                    console.log('returnEnderecos >> ' + JSON.stringify(returnEnderecos));
                    console.log('this.listEnderecos >> ' + JSON.stringify(this.listEnderecos));
                } else {
                    this.texto = 'Não há histórico de ENDEREÇOS para essa matrícula!';
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
        const cloneData = [...this.listEnderecos];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.listEnderecos = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }
}