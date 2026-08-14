@IsTest
private class PricingEngineTest {

    @IsTest static void engineStaysApex() {
        Decimal p = PricingEngine.compute(100, 120, 'WATER', 'GOLD');
        System.assert(p > 0);
        System.assertEquals(0, PromotionOptimizer.optimize(new List<Decimal>()));
    }

}
