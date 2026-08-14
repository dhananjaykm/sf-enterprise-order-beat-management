public with sharing class PromotionTriggerHandler extends TriggerHandlerBase {
    public override void beforeInsert(List<SObject> newList) {
        for (Promotion__c p : (List<Promotion__c>) newList) {
            if (p.End_Date__c == null) p.End_Date__c = Date.today().addDays(30);
        }
    }
}
