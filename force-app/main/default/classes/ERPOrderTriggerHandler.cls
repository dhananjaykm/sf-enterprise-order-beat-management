public with sharing class ERPOrderTriggerHandler extends TriggerHandlerBase {
    public override void afterInsert(List<SObject> newList) {
        for (ERP_Order__c e : (List<ERP_Order__c>) newList) {
            if (e.Status__c == 'Queued' && e.Order__c != null) {
                System.enqueueJob(new ERPOrderQueueable(e.Order__c));
            }
        }
    }
}
