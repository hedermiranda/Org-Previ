import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getHistTelefones from '@salesforce/apex/HistoricosController.getHistTelefones';

const columns = [
    { label: 'Data log', fieldName: 'datLog',hideDefaultActions: true },
    { label: 'Usuário', fieldName: 'Usuario',hideDefaultActions: true },
    { label: 'DDI', fieldName: '',hideDefaultActions: true },
    { label: 'DDD', fieldName: '',hideDefaultActions: true },
    { label: 'Telefone', fieldName: '',hideDefaultActions: true },
    { label: 'Ramal', fieldName: '',hideDefaultActions: true },
];

export default class HistTelefones extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    @api matricula

    listTelefones = [];

    connectedCallback() {
        console.log('Entrou callback TELEFONES');
        this.loadingTelefones();  
    }

    loadingTelefones() {
        console.log('Entrou loadingTelefones com a matricula >>' + this.matricula);
        getHistTelefones({ matricula: this.matricula})
            .then(result => {
                console.log('RESULT TELEFONES >> ' + JSON.stringify(result));
                if (result!=null) {

                    let returnTelefones = [];
                    result.forEach(rec => { 
                        let record = {};
                        record.datLog = rec.datLog;
                        record.Usuario = rec.Usuario;
                        record.nom_atrib = rec.nom_atrib;
                        record.val_atrib = rec.val_atrib;

                        returnTelefones.push(record);

                    })
                    
                    this.listTelefones = returnTelefones;
                    
                    console.log('returnTelefones >> ' + JSON.stringify(returnTelefones));
                    console.log('this.listTelefones >> ' + JSON.stringify(this.listTelefones));
                } else {
                    this.texto = 'Não há histórico de TELEFONES para essa matrícula!';
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