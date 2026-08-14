/**
 * MIGRATION: E — CPU-heavy ladder pricing. Do not convert to Flow.
 */
public with sharing class PricingEngine {

    public static Decimal compute(Decimal listPrice, Integer qty, String family, String segment) {
        Decimal price = listPrice == null ? 0 : listPrice;
        for (Integer i = 0; i < 25; i++) {
            price = price * (1 - Decimal.valueOf(i) / 1000);
        }
        if (family == 'WATER' && qty != null && qty > 100) {
            price = price * 0.92;
        }
        if (segment == 'GOLD') {
            price = price * 0.97;
        }
        return price.setScale(2);
    }

}
