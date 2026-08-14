/**
 * MIGRATION: A — before-save record-triggered Flow.
 */
public with sharing class OrderFieldDerivationService {

    public static void derive(List<Order> orders) {
        Set<Id> outletIds = new Set<Id>();
        for (Order o : orders) {
            if (o.Outlet__c != null) outletIds.add(o.Outlet__c);
            if (String.isBlank(o.Submission_Status__c)) o.Submission_Status__c = 'Draft';
            if (String.isBlank(o.Order_Priority__c)) o.Order_Priority__c = 'Normal';
        }
        Map<Id, Outlet__c> outlets = OutletSelector.byIds(outletIds);
        for (Order o : orders) {
            Outlet__c outlet = outlets.get(o.Outlet__c);
            if (outlet == null) continue;
            o.Beat__c = outlet.Beat__c;
            o.Customer_Segment__c = outlet.Segment__c;
            if (outlet.Segment__c == 'GOLD') {
                o.Order_Priority__c = 'High';
            }
        }
    }

}
