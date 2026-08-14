public with sharing class OrderSelector {
    public static List<Order> byIds(Set<Id> ids) {
        return [SELECT Id, Status, AccountId, Beat__c, Outlet__c, Customer_Segment__c, Order_Priority__c,
                       Discount_Percent__c, Credit_Check_Status__c, Submission_Status__c, TotalAmount, EffectiveDate
                FROM Order WHERE Id IN :ids];
    }
}
