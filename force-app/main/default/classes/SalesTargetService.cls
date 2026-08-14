/**
 * MIGRATION: A — after order close, increment target actual.
 */
public with sharing class SalesTargetService {

    public static void rollup(List<Order> orders) {
        Set<Id> beatIds = new Set<Id>();
        for (Order o : orders) if (o.Beat__c != null) beatIds.add(o.Beat__c);
        List<Sales_Target__c> targets = [SELECT Id, Beat__c, Amount_Actual__c FROM Sales_Target__c WHERE Beat__c IN :beatIds];
        Map<Id, Sales_Target__c> byBeat = new Map<Id, Sales_Target__c>();
        for (Sales_Target__c t : targets) byBeat.put(t.Beat__c, t);
        for (Order o : orders) {
            Sales_Target__c t = byBeat.get(o.Beat__c);
            if (t == null) continue;
            t.Amount_Actual__c = (t.Amount_Actual__c == null ? 0 : t.Amount_Actual__c) + (o.TotalAmount == null ? 0 : o.TotalAmount);
        }
        if (!targets.isEmpty()) update targets;
    }

}
