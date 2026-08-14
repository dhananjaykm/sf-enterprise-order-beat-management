public with sharing class BeatVisitTriggerHandler extends TriggerHandlerBase {
    public override void beforeUpdate(List<SObject> newList, Map<Id, SObject> oldMap) {
        BeatVisitService.startVisit((List<Beat_Visit__c>) newList);
    }
}
