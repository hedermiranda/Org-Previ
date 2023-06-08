import { LightningElement,api } from 'lwc';
import getRegistration from '@salesforce/apex/IntegrationESController.getRegistration';


export default class HomeAposentadoria extends LightningElement {

    
    listEspComplemento = [];
    @api matricula;

    connectedCallback() {
        //this.isModalOpen = true;
        this.getMatricula();
    }

    getMatricula() {
        getRegistration({ recordId: this.recordId })
            .then(result => {
                if (result != '') {
                    this.matricula = result;
                    //this.matricula = '3328440';
                    
                }
            })
            .catch((error) => {
                console.log('error', error);
            });
    }


    /**
    * Inicializa a Página chamando os API's de Anotação e Emprestimo.
    */
/*
    connectedCallback() {

        this.EspComplemento();
        
        if (this.isCssLoaded) return
        this.isCssLoaded = true
        loadStyle(this, COLORS).then(() => {
            console.log("Loaded Successfully")
        }).catch(error => {
            console.error("Error in loading the colors")
        })

    }

    async EspComplemento() {
        await getEspComplemento({ matricula: this.matricula })
            //await getModalidades({ matricula: '6001835' })
            .then(result => {
                if (result != null) {
                    if (result.erro != true || result.erro == undefined) {                      
                        this.listEspComplemento = [{ label: result.espPrevi, value: result.dibPrevi }];         
                } else {
                    this.showNotification('ATENÇÃO!', 'Não há opções de empréstimos rotativos disponíveis', 'error', 'dismissible');
                }
            }
            })
            .catch(error => {
                console.log('error ', error);
                this.showNotification('ERRO MODALIDADES', error, 'error', 'dismissible');
            });
    } */

    
}