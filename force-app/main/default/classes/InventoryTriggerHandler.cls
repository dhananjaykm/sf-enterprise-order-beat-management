public with sharing class InventoryTriggerHandler extends TriggerHandlerBase {
    public override void afterInsert(List<SObject> newList) {
        InventoryService.flagZero((List<Inventory_Snapshot__c>) newList);
    }
}
