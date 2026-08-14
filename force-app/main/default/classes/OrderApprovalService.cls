/**
 * MIGRATION: A — after-save Flow + Approval Process when discount > threshold.
 */
public with sharing class OrderApprovalService {

    public static void requestIfNeeded(List<Order> orders, Map<Id, Order> oldMap) {
        List<Order_Approval__c> reqs = new List<Order_Approval__c>();
        for (Order o : orders) {
            Boolean submitted = o.Submission_Status__c == 'Submitted';
            Boolean was = oldMap != null && oldMap.containsKey(o.Id) && oldMap.get(o.Id).Submission_Status__c == 'Submitted';
            if (submitted && !was && o.Discount_Percent__c != null && o.Discount_Percent__c > 10) {
                reqs.add(new Order_Approval__c(Order__c = o.Id, Status__c = 'Requested', Discount_Percent__c = o.Discount_Percent__c, Reason__c = 'Discount exceeds 10%'));
            }
        }
        if (!reqs.isEmpty()) insert reqs;
    }

}
