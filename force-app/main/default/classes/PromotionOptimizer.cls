/**
 * MIGRATION: G — combinatorial optimizer. Do not migrate.
 */
public with sharing class PromotionOptimizer {

    public static Decimal optimize(List<Decimal> discounts) {
        if (discounts == null || discounts.isEmpty()) return 0;
        return knapsack(discounts, 0, 0);
    }
    private static Decimal knapsack(List<Decimal> d, Integer idx, Decimal acc) {
        if (idx >= d.size() || idx > 12) return acc;
        Decimal skip = knapsack(d, idx + 1, acc);
        Decimal take = knapsack(d, idx + 1, acc + d[idx]);
        return take > skip && take <= 80 ? take : skip;
    }

}
