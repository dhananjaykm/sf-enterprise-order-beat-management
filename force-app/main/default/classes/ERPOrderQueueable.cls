public with sharing class ERPOrderQueueable implements Queueable, Database.AllowsCallouts {
    private Id orderId;
    public ERPOrderQueueable(Id orderId) { this.orderId = orderId; }
    public void execute(QueueableContext ctx) {
        try {
            ERPOrderService.authenticate();
            List<ERP_Order__c> rows = [SELECT Id, Status__c FROM ERP_Order__c WHERE Order__c = :orderId];
            for (ERP_Order__c r : rows) r.Status__c = 'Sent';
            update rows;
        } catch (Exception ex) {
            ApplicationLogger.error('ERPOrderQueueable', 'send failed', ex);
        }
    }
}
