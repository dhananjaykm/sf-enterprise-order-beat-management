/**
 * MIGRATION: E — large-volume reconciliation. Not Flow.
 */
public with sharing class OrderFulfillmentBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Submission_Status__c FROM Order WHERE Submission_Status__c = 'Submitted']);
    }
    public void execute(Database.BatchableContext bc, List<Order> scope) {
        for (Order o : scope) {
            o.Submission_Status__c = 'Fulfilled';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc) {
        OrderFulfillmentService.createFollowups(Date.today());
    }
}
