public class SearchContactCase {
   /* public static Integer searchContact(Id casoId) {
        Integer countCs = 0;
        Case casoAtual = [SELECT Id, ContactId, Status, Sub_Status__c, Casos_aberto_do_mesmo_Contato__c FROM Case WHERE Id = :casoId];
        // Verificar apenas se o caso estiver nos status especificados
        if (casoAtual.Status == 'Aguardando Retorno' || (casoAtual.Status == 'Aguardando 2° nível' && casoAtual.Sub_Status__c == 'Revisado')) {
            List<Case> casosComMesmoContato = [SELECT Id FROM Case WHERE ContactId = :casoAtual.ContactId AND (Status = 'Aguardando Retorno' OR (Status = 'Aguardando 2° nível' AND Sub_Status__c = 'Revisado')) AND Id != :casoId];
            
            if (!casosComMesmoContato.isEmpty()) {
                // Existem outros casos com o mesmo contato
                countCs = casosComMesmoContato.size();
                System.debug('casosComMesmoContato: ' + casosComMesmoContato);
                System.debug('countCs: ' + countCs);
                casoAtual.Casos_aberto_do_mesmo_Contato__c = countCs;
                update casoAtual;
                return countCs;
            }
        }
        System.debug('Caso Atual: ' + casoAtual);
        
        System.debug('countCs: ' + countCs);
        return countCs;
    }*/
}