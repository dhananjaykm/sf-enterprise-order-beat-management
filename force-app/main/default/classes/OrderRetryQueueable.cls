public with sharing class OrderRetryQueueable implements Queueable, Database.AllowsCallouts {
    private Set<Id> erpIds;
    public OrderRetryQueueable(Set<Id> erpIds) { this.erpIds = erpIds; }
    public void execute(QueueableContext ctx) {
        List<ERP_Order__c> rows = [SELECT Id, Status__c, Retry_Count__c, Payload__c FROM ERP_Order__c WHERE Id IN :erpIds];
        for (ERP_Order__c row : rows) {
            row.Retry_Count__c = (row.Retry_Count__c == null ? 0 : row.Retry_Count__c) + 1;
            row.Status__c = row.Retry_Count__c > 3 ? 'Failed' : 'Retry';
        }
        update rows;
    }
}
