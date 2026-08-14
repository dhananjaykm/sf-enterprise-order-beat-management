/**
 * MIGRATION: D — lookup is Flow; stacking optimizer is Apex.
 */
public with sharing class OrderPromotionService {

    public static Decimal bestDiscount(Integer qty, String family) {
        Decimal best = 0;
        for (Promotion__c p : PromotionSelector.active()) {
            for (Promotion_Rule__c r : p.Rules__r) {
                if ((String.isBlank(r.Product_Family__c) || r.Product_Family__c == family) && qty >= r.Min_Qty__c) {
                    if (r.Discount_Percent__c > best) best = r.Discount_Percent__c;
                }
            }
        }
        return best;
    }

    public static Decimal optimizeStack(List<Decimal> discounts) {
        return PromotionOptimizer.optimize(discounts);
    }

}
