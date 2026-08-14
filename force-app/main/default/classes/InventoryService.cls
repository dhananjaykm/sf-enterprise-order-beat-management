/**
 * MIGRATION: A for zero-qty tasks; E for allocation.
 */
public with sharing class InventoryService {

    public static void flagZero(List<Inventory_Snapshot__c> snaps) {
        List<Task> tasks = new List<Task>();
        for (Inventory_Snapshot__c s : snaps) {
            if (s.Quantity__c == 0) {
                tasks.add(new Task(Subject = 'Replenish inventory', WhatId = s.Id, ActivityDate = Date.today(), Status = 'Not Started'));
            }
        }
        if (!tasks.isEmpty()) insert tasks;
    }

}
