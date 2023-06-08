import { LightningElement, api, wire} from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getProtocolos from '@salesforce/apex/HistoricosController.getProtocolos';
import getRegistration from '@salesforce/apex/IntegrationESController.getRegistration';

const columns = [
    { label: 'Nº do Protocolo', fieldName: 'protocolo',hideDefaultActions: true },
    { label: 'Data/Hora', fieldName: 'dataProtocolo',hideDefaultActions: true },
    { label: 'Origem', fieldName: 'origem',hideDefaultActions: true },
    { label: 'Transação', fieldName: 'transacao',hideDefaultActions: true },
    { label: 'Situação', fieldName: 'situacao',hideDefaultActions: true},
];

export default class Historicos extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    listProtocolos = [];
    
    @api recordId ;
    matricula;

    

    connectedCallback() {
        console.log('Entrou callback');
        this.getmatricula();
    }

   getmatricula() {
        getRegistration({ recordId : this.recordId })
            .then(result => {        
                if (result != '') {                    
                    this.matricula = result;
                    console.log('this.matricula no getMatricula >> ' + this.matricula);
                }
            })
            .catch((error) => {
                console.log('error', error);
            })
            .finally( () => {        
                if(this.matricula != undefined){
                    console.log('.finally ' );
                    this.loadingProtocolos(); 
                }
            })

        
                          
    }

    loadingProtocolos() {
        console.log('Entrou loadingProtocolos com a matricula >>' + this.matricula);
        getProtocolos({ matricula: this.matricula, idOrigemMatricula: '1'})
            .then(result => {
                console.log('RESULT >> ' + JSON.stringify(result));
                console.log('RESULT >> ' + JSON.stringify(result).length);
                if (JSON.stringify(result).length > 4) {

                    let returnProtocolos = [];
                    result.forEach(rec => {
                        let record = {};
                        record.protocolo = rec.protocolo;
                        record.dataProtocolo = rec.dataProtocolo;
                        record.origem = rec.origem;
                        record.transacao = rec.transacao;
                        record.situacao = rec.situacao;

                        returnProtocolos.push(record);
                    })
                    
                    this.listProtocolos = returnProtocolos;
                    console.log('returnProtocolos >> ' + returnProtocolos);
                    console.log('this.listProtocolos >> ' + this.listProtocolos);
                } else {
                    this.texto = 'Não há histórico de PROTOCOLOS para essa matrícula!';
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