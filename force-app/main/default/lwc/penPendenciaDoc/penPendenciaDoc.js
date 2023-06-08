import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getPendenciaDocumentos from '@salesforce/apex/IntegrationPensaoController.getPendenciaDocumentos';

const columns = [
    { label: 'Descricao do Documento', fieldName: 'descricao_doc',hideDefaultActions: true },
    { label: 'Descricao do Cadastramento', fieldName: 'data_cadastro',hideDefaultActions: true },
];

export default class PenPendenciaDoc extends LightningElement {
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    loading = true;
    @api matricula
    @api pensionistaList;
    pendenciasList = [];
    listPendencias = [];

    connectedCallback() {
        console.log('Entrou callback Pendencias');
        console.log('pensionistaList'+this.matricula);
        if (this.pensionistaList != null){
            for (let item in this.pensionistaList) {
                console.log('grupo ' + this.pensionistaList[item].grupo);
                console.log('idPensionista ' + this.pensionistaList[item].idPensionista);
                this.getPendenciaDocumentos('4556294'/*this.matricula*/, '1'/*this.pensionistaList[item].grupo*/, '229477'/*this.pensionistaList[item].idPensionista*/);    
            }
        }
    }

    getPendenciaDocumentos(mat, grupo, pensionista) {
        getPendenciaDocumentos({ matricula : mat, grupo : grupo, pensionista : pensionista })
            .then(result => {        
                if (result != '') {
                    console.log('mat'+mat);
                    console.log('grupo'+grupo);
                    console.log('pensionista'+pensionista);
                    console.log('result'+result);
                    this.pendenciasList = result;
                    if (this.pendenciasList != null){
                        console.log('this.pendenciasList ' + JSON.stringify(this.pendenciasList));
                        
                        for (let item in this.pendenciasList) {
                            this.listPendencias.push({
                                descricao_doc: this.pendenciasList[item].descricao_doc,                  
                                data_cadastro : this.pendenciasList[item].data_cadastro
                            });  
                        }
                    }
                    console.log('listPendencias ', this.listPendencias);
                }
                this.loading = false;
            })
            .catch((error) => {
                console.log('error', error);
            });
    }
}