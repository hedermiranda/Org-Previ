import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import BILLING_STREET from '@salesforce/schema/Account.BillingStreet';
import BILLING_CITY from '@salesforce/schema/Account.BillingCity';
import BILLING_COUNTRY from '@salesforce/schema/Account.BillingCountry';
import BILLING_POSTAL_CODE from '@salesforce/schema/Account.BillingPostalCode';
import BILLING_STATE from '@salesforce/schema/Account.BillingState';
import DISTRICT from '@salesforce/schema/Account.District__c';
import COMPLEMENTO from '@salesforce/schema/Account.Complemento__c';
import RESGISTRATION from '@salesforce/schema/Account.Registration__c';


import sendEndereco from '@salesforce/apex/BillingAddressCustomController.sendEndereco';


export default class BillingAddressCustom extends LightningElement {

    //Declaração de Váriavéis.
    @api recordId;
    spinner = false;
    isEdit = false;
    isDetail = true;

    activeSections = ['endereco'];
    street;
    city;
    province;
    country;
    postalCode;
    distrito;
    complements;
    AccountId;
    desativeSalvar = false;

    /**
    * Funções para inicializar os campos do lightning-input-address com os campos do registro do Cadastro.
    */
    @wire(getRecord, { recordId: '$recordId', fields: [BILLING_STREET, BILLING_CITY, BILLING_COUNTRY, BILLING_POSTAL_CODE, BILLING_STATE, DISTRICT, COMPLEMENTO, RESGISTRATION] })
    account;

    get billingStreet() {
        return getFieldValue(this.account.data, BILLING_STREET);
    }
    get billingCity() {
        return getFieldValue(this.account.data, BILLING_CITY);
    }
    get billingCountry() {
        return getFieldValue(this.account.data, BILLING_COUNTRY);
    }
    get billingPostalCode() {
        return getFieldValue(this.account.data, BILLING_POSTAL_CODE);
    }
    get billingState() {
        return getFieldValue(this.account.data, BILLING_STATE);
    }
    get district() {
        return getFieldValue(this.account.data, DISTRICT);
    }
    get complemento() {
        return getFieldValue(this.account.data, COMPLEMENTO);
    }
    get Registration() {
        return getFieldValue(this.account.data, RESGISTRATION);
    }

    /**
    * Inicializa a Página deixando a pagina de Registro aberta.
    */
    connectedCallback() { this.isDetail = true; }

    /**
    * Ação chamada no onclick do ícone, fechar a página de Registro e abre a de Edição do endereço de Cadastro.
    */
    isEditTemplate() {
        this.isEdit = true;
        this.isDetail = false;
    }

    /**
    * Ação chamada no onchange do botão Salvar, onde chama a integração de endereço e após o response exibe o sucesso ou erro em tela.
    */
    save(event) {
        //Pega valores  do lightning-input.
        this.distrito = this.template.querySelector('[data-id="Bairro"]').value;
        this.complements = this.template.querySelector('[data-id="Complemento"]').value;

        this.isNotChangeInputAdress();
        if (this.validateFields() == true) {
            //Verifica se foi inserida a vírgula para fazer o tratamento do campo número e rua.
            if (this.street.includes(',')) {
                let conta = {
                    BillingState: this.province,
                    BillingStreet: this.street,
                    BillingCity: this.city,
                    BillingCountry: this.country,
                    District: this.distrito,
                    Complemento: this.complements,
                    BillingPostalCode: this.postalCode,
                    Registration: this.Registration,
                    AccountId: this.recordId
                }
                //Ativa a Spinner.
                this.spinner = true;
                //Call apex
                sendEndereco({
                    conta: conta
                })
                    .then(data => {
                        if (data.success === true) {
                            this.showNotification('SUCCESS', '', 'Success', 'dismissible');
                            //Desativa Spinner.
                            this.spinner = false;
                            //Fechar a página de edição do Endereço de Cobrança do Cadastro.
                            this.isEdit = false;
                            //Abre a página de detalhe do Registro.
                            this.isDetail = true;
                            //Refresha a Página.
                            updateRecord({ fields: { Id: this.recordId } })
                        } else {
                            this.showNotification('ERRO', data.result, 'error', 'sticky');
                            this.spinner = false;
                        }

                    })
                    .catch(error => {
                        console.log(error);
                        this.showNotification('ERRO', error, 'error', 'sticky');
                        this.spinner = false;
                    });

            } else {
                this.showNotification('ERRO', 'Insira uma vígula antes do número!' + ' EX: Nome da rua, número ou S/N ', 'error', 'dismissible');
                this.spinner = false;
            }
        }
    }

    /**
    * Ação chamada no onchange do botão Cancelar, muda da página de edição e volta para pagina de exibição do registro.
    */
    handleCancel() {
        this.isEdit = false;
        this.isDetail = true;
    }

    /**
    * Ação chamada no onchange do lightning-input-address para pegar alteração.
    */
    genericInputChange(event) {
        this.street = event.target.street;
        this.city = event.target.city;
        this.province = event.target.province;
        this.country = event.target.country;
        this.postalCode = event.target.postalCode;
    }

    /**
    * Verifica se houve alteração nos campos do lightning-input-address senão inicia com valores do Registro.
    */
    isNotChangeInputAdress() {
        if (this.street === undefined) { this.street = this.billingStreet; }
        if (this.city === undefined) { this.city = this.billingCity; }
        if (this.province === undefined) { this.province = this.billingState; }
        if (this.country === undefined) { this.country = this.billingCountry; }
        if (this.postalCode === undefined) { this.postalCode = this.billingPostalCode; }
    }

    /**
    * Faz validações nos campos da tela. 
    */
    validateFields() {
        var msn = '';

        if (this.street == '') {
            msn = "Preencha o campo Rua de cobrança";
        } else if (this.city == '') {
            msn = "Preencha o campo Cidade de cobrança";
        } else if (this.province == '') {
            msn = "Preencha o campo Estado/Província de cobrança";
        } else if (this.country == '') {
            msn = "Preencha o campo País";
        } else if (this.postalCode == '') {
            msn = "Preencha o campo CEP de cobrança";
        } else if (this.postalCode != '' && this.postalCode.length >= 9 || this.postalCode.length < 8) {
            this.postalCode = this.postalCode.replace('-', '');
            if (this.postalCode.length >= 9 || this.postalCode.length < 8) {
                msn = "Verifique seu CEP de cobrança";
            }
        } else if (this.distrito == '') {
            msn = "Preencha o campo Bairro";
        }
        if (msn != "") {
            this.showNotification('ERRO', msn, 'error', 'dismissible');
            return false;
        } else {
            return true;
        }

    }

    /**
    * Exibe Toast onde variant-info,success,warning,error e mode-dismissible,pester,sticky.
    */
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

    /**
    * Remove acentos de caracteres
    * @param  {String} stringComAcento [string que contem os acentos]
    * @return {String}                 [string sem acentos]
    */
    removerAcentos(newStringComAcento) {
        var string = newStringComAcento;
        var mapaAcentosHex = {
            a: /[\xE0-\xE6]/g,
            A: /[\xC0-\xC6]/g,
            e: /[\xE8-\xEB]/g,
            E: /[\xC8-\xCB]/g,
            i: /[\xEC-\xEF]/g,
            I: /[\xCC-\xCF]/g,
            o: /[\xF2-\xF6]/g,
            O: /[\xD2-\xD6]/g,
            u: /[\xF9-\xFC]/g,
            U: /[\xD9-\xDC]/g,
            c: /\xE7/g,
            C: /\xC7/g,
            n: /\xF1/g,
            N: /\xD1/g,
        };

        for (var letra in mapaAcentosHex) {
            var expressaoRegular = mapaAcentosHex[letra];
            string = string.replace(expressaoRegular, letra);
        }

        return string;
    }


}