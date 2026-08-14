public with sharing class CollectionTriggerHandler extends TriggerHandlerBase {
    public override void beforeInsert(List<SObject> newList) {
        for (Collection__c c : (List<Collection__c>) newList) {
            if (c.Due_Date__c < Date.today()) c.Status__c = 'Overdue';
        }
    }
}
