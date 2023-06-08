import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getRepresentantesLegais from '@salesforce/apex/HistoricosController.getRepresentantesLegais';

const columns = [
    //{ label: 'Descrição Situação', fieldName: 'descSituacao',hideDefaultActions: true },
    { label: 'Observação', fieldName: 'descObs',hideDefaultActions: true },
    { label: 'Início Vigência Documento', fieldName: 'dataIni',hideDefaultActions: true },
    { label: 'Fim Vigência Documento', fieldName: 'dataFim',hideDefaultActions: true },
    { label: 'Data Inclusão', fieldName: 'dataIncl',hideDefaultActions: true },
    { label: 'Nome', fieldName: 'represLegal',hideDefaultActions: true, wrapText: true },
    { label: 'CPF', fieldName: 'cpfRepresLegal',hideDefaultActions: true, wrapText: true },
    { label: 'Endereço', fieldName: 'endRepresLegal',hideDefaultActions: true },
    { label: 'Bairro', fieldName: 'bairro',hideDefaultActions: true },
    { label: 'Município', fieldName: 'municipio',hideDefaultActions: true },
    { label: 'UF', fieldName: 'codigoUF',hideDefaultActions: true },
    { label: 'CEP', fieldName: 'codigoCEP',hideDefaultActions: true },
    { label: 'DDD', fieldName: 'codigoDDD',hideDefaultActions: true },
    { label: 'Telefone', fieldName: 'numTel',hideDefaultActions: true },
    { label: 'Celular', fieldName: 'numCel',hideDefaultActions: true },
    { label: 'E-mail', fieldName: 'email',hideDefaultActions: true },
];

    

export default class HistRepreLegais extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    texto;
    loading = true;
    
    @api matricula
    
    listRepreLegais = [];

    connectedCallback() {
        console.log('Entrou callback REPRELEGAIS');
        this.loadingRepreLegais();  
    }

    loadingRepreLegais() {
        console.log('Entrou loadingRepreLegais com a matricula >>' + this.matricula);
        getRepresentantesLegais({ matricula: this.matricula})
            .then(result => {
                console.log('RESULT >> ' + JSON.stringify(result));
                if (result != null) {

                    let returnRepreLegais = [];
                    result.forEach(rec => {
                        let record = {};
                        //record.descSituacao = rec.descSituacao;
                        record.descObs = rec.descObs;
                        record.dataIni = rec.dataIni;
                        record.dataFim = rec.dataFim;
                        record.dataIncl = rec.dataIncl;
                        record.represLegal = rec.represLegal;
                        record.cpfRepresLegal = rec.cpfRepresLegal;
                        record.endRepresLegal = rec.endRepresLegal;
                        record.bairro = rec.bairro;
                        record.municipio = rec.municipio;
                        record.codigoUF = rec.codigoUF;
                        record.codigoCEP = rec.codigoCEP;
                        record.codigoDDD = rec.codigoDDD;
                        record.numTel = rec.numTel;
                        record.numCel = rec.numCel;
                        record.email = rec.email;

                        returnRepreLegais.push(record);

                    })
                    
                    this.listRepreLegais = returnRepreLegais;
                    
                    console.log('returnRepreLegais >> ' + JSON.stringify(returnRepreLegais));
                    console.log('this.listFlistRepreLegaisuncoes >> ' + JSON.stringify(this.listRepreLegais));
                } else {
                    this.texto = 'Não há histórico de REPRESENTANTES LEGAIS para essa matrícula!'
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