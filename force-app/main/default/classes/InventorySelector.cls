public with sharing class InventorySelector {
    public static List<Inventory_Snapshot__c> latest(Set<Id> outletIds) {
        return [SELECT Id, Outlet__c, Product__c, Quantity__c, Warehouse__c, Snapshot_Date__c
                FROM Inventory_Snapshot__c WHERE Outlet__c IN :outletIds ORDER BY Snapshot_Date__c DESC];
    }
}
