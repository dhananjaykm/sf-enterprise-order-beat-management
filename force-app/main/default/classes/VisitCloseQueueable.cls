public with sharing class VisitCloseQueueable implements Queueable {
    private Set<Id> visitIds;
    public VisitCloseQueueable(Set<Id> visitIds) { this.visitIds = visitIds; }
    public void execute(QueueableContext ctx) {
        List<Beat_Visit__c> visits = [SELECT Id, Status__c FROM Beat_Visit__c WHERE Id IN :visitIds];
        for (Beat_Visit__c v : visits) v.Status__c = 'Completed';
        update visits;
    }
}
