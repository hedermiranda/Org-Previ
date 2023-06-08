import { LightningElement , api} from 'lwc';

export default class UpdateInformation extends LightningElement {
    @api invocke(){
        console.log('Chamada');
    }


    value = ['telefone'];
    get options() {
        return [
            { label: 'Email', value: 'email' },
            { label: 'Telefone', value: 'telefone' },
            { label: 'Endereço', value: 'endereco' },
        ];
    }

    get selectedValues() {
        return this.value.join(',');
    }
}