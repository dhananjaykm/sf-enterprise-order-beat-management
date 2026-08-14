public with sharing class OutletTriggerHandler extends TriggerHandlerBase {
    public override void beforeInsert(List<SObject> newList) {
        for (Outlet__c o : (List<Outlet__c>) newList) {
            if (String.isBlank(o.Segment__c)) o.Segment__c = 'BRONZE';
        }
    }
}
