public with sharing class CollectionEscalationQueueable implements Queueable {
    public void execute(QueueableContext ctx) {
        List<Collection__c> overdue = [SELECT Id, Status__c, Outlet__c FROM Collection__c WHERE Due_Date__c < :Date.today() AND Status__c != 'Collected' LIMIT 200];
        for (Collection__c c : overdue) c.Status__c = 'Overdue';
        if (!overdue.isEmpty()) update overdue;
    }
}
