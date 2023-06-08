import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getConcessaoInssPrisma from '@salesforce/apex/IntegrationPensaoController.getConcessaoInssPrisma';

export default class TabAposConcInss extends LightningElement {
    loading = true;
    @api matricula
    concessaoINSSList = [];
    listConcessaoINSSPrisma = [];
    listConcessaoINSS = [];
    ddd = '';
    tel = '';

    connectedCallback() {
        this.getConcessaoInssPrisma('3801533'/*this.matricula*/);
    }

    getConcessaoInssPrisma(mat) {
        getConcessaoInssPrisma({ matricula: mat })
            .then(result => {
                if (result != '') {
                    console.log('mat' + mat);
                    console.log('result' + result);
                    this.concessaoINSSList = result;
                    if (this.concessaoINSSList != null) {
                        console.log('this.concessaoINSSList ' + JSON.stringify(this.concessaoINSSList));
                        if (this.concessaoINSSList.dd1 != null) {
                            this.ddd += this.concessaoINSSList.dd1;
                        }
                        if (this.concessaoINSSList.dd2 != null) {
                            this.ddd += ',' + this.concessaoINSSList.dd2;
                        }
                        if (this.concessaoINSSList.dd3 != null) {
                            this.ddd += ',' + this.concessaoINSSList.dd3;
                        }
                        if (this.concessaoINSSList.tel1 != null) {
                            this.tel += this.concessaoINSSList.tel1;
                        }
                        if (this.concessaoINSSList.tel2 != null) {
                            this.tel += ',' + this.concessaoINSSList.tel2;
                        }
                        if (this.concessaoINSSList.tel3 != null) {
                            this.tel += ',' + this.concessaoINSSList.tel3;
                        }
                        this.listConcessaoINSS.push({
                            tipoBenef: this.concessaoINSSList.tipoBenef,
                            especieNb: this.concessaoINSSList.especieNb,
                            num_beneficio: this.concessaoINSSList.num_beneficio,
                            dib: this.concessaoINSSList.dib,
                            nome: this.concessaoINSSList.nome,
                            cpf: this.concessaoINSSList.cpf,
                            dv: this.concessaoINSSList.dv,
                            vinculo: this.concessaoINSSList.vinculo,
                            sexo: this.concessaoINSSList.sexo,
                            dataNasc: this.concessaoINSSList.dataNasc,
                            tit: this.concessaoINSSList.tit,
                            inv: this.concessaoINSSList.inv,
                            rl: this.concessaoINSSList.rl,
                            endereco: this.concessaoINSSList.endereco,
                            numero: this.concessaoINSSList.numero,
                            complemento: this.concessaoINSSList.complemento,
                            bairro: this.concessaoINSSList.bairro,
                            municipio: this.concessaoINSSList.municipio,
                            cep: this.concessaoINSSList.cep + '-' + this.concessaoINSSList.complCep,
                            uf: this.concessaoINSSList.uf,
                            ddd: this.ddd,
                            tel: this.tel,
                            email: this.concessaoINSSList.email
                        });

                        console.log('listConcessaoINSS ', this.listConcessaoINSS);

                        for (let item in this.concessaoINSSList.concessao_inss_prisma) {
                            this.listConcessaoINSSPrisma.push({
                                data: this.concessaoINSSList.concessao_inss_prisma[item].data,
                                descricao: this.concessaoINSSList.concessao_inss_prisma[item].descricao
                            });
                        }
                    }
                    console.log('listConcessaoINSSPrisma ', this.listConcessaoINSSPrisma);
                }
                this.loading = false;
            })
            .catch((error) => {
                console.log('error', error);
            });
    }
}