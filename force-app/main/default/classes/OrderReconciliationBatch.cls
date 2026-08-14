public with sharing class OrderReconciliationBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Status__c FROM ERP_Order__c WHERE Status__c IN ('Sent','Retry')]);
    }
    public void execute(Database.BatchableContext bc, List<ERP_Order__c> scope) {
        for (ERP_Order__c e : scope) {
            if (e.Status__c == 'Retry') e.Status__c = 'Failed';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc) {}
}
