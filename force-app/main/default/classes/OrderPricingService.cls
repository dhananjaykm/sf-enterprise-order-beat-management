/**
 * MIGRATION: E/B — simple segment discount is Flow; engine stays Apex.
 */
public with sharing class OrderPricingService {

    public static Decimal segmentDiscount(String segment) {
        for (Pricing_Rule__mdt rule : [SELECT Segment__c, Discount_Percent__c FROM Pricing_Rule__mdt]) {
            if (rule.Segment__c == segment) {
                return rule.Discount_Percent__c;
            }
        }
        return 0;
    }

    public static void applySimpleDiscount(List<Order> orders) {
        for (Order o : orders) {
            o.Discount_Percent__c = segmentDiscount(o.Customer_Segment__c);
        }
    }

}
