public with sharing class PaymentTriggerHandler extends TriggerHandlerBase {
    public override void afterInsert(List<SObject> newList) {
        PaymentFailureService.onFailure((List<Payment__c>) newList);
        PaymentAllocationService.allocate((List<Payment__c>) newList);
    }
    public override void afterUpdate(List<SObject> newList, Map<Id, SObject> oldMap) {
        PaymentFailureService.onFailure((List<Payment__c>) newList);
    }
}
