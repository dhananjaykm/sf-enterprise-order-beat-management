/**
 * MIGRATION: A — record-triggered Flow: update account risk, create collection task, notify.
 */
public with sharing class PaymentFailureService {

    public static void onFailure(List<Payment__c> payments) {
        Set<Id> outletIds = new Set<Id>();
        for (Payment__c p : payments) if (p.Status__c == 'Failed' && p.Outlet__c != null) outletIds.add(p.Outlet__c);
        Map<Id, Outlet__c> outlets = OutletSelector.byIds(outletIds);
        List<Outlet__c> dirty = new List<Outlet__c>();
        List<Task> tasks = new List<Task>();
        List<Account> accounts = new List<Account>();
        for (Outlet__c o : outlets.values()) {
            o.Risk_Flag__c = true;
            dirty.add(o);
            tasks.add(new Task(Subject = 'Collect failed payment', WhatId = o.Id, Status = 'Not Started', Priority = 'High', ActivityDate = Date.today()));
            if (o.Account__c != null) {
                accounts.add(new Account(Id = o.Account__c, Risk_Score__c = 80, Collection_Hold__c = true));
            }
        }
        if (!dirty.isEmpty()) update dirty;
        if (!tasks.isEmpty()) insert tasks;
        if (!accounts.isEmpty()) update accounts;
    }

}
