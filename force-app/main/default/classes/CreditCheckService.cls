/**
 * MIGRATION: B — threshold decision is Flow; AR calc stays Invocable Apex.
 */
public with sharing class CreditCheckService {

    public static void check(List<Order> orders) {
        Set<Id> outletIds = new Set<Id>();
        for (Order o : orders) if (o.Outlet__c != null) outletIds.add(o.Outlet__c);
        Map<Id, Outlet__c> outlets = OutletSelector.byIds(outletIds);
        for (Order o : orders) {
            Outlet__c outlet = outlets.get(o.Outlet__c);
            if (outlet == null) {
                o.Credit_Check_Status__c = 'Pending';
                continue;
            }
            Decimal projected = (outlet.Open_AR__c == null ? 0 : outlet.Open_AR__c) + (o.TotalAmount == null ? 0 : o.TotalAmount);
            if (outlet.Credit_Limit__c != null && projected > outlet.Credit_Limit__c) {
                o.Credit_Check_Status__c = 'Fail';
            } else {
                o.Credit_Check_Status__c = 'Pass';
            }
        }
    }

}
