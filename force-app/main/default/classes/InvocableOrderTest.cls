@IsTest
private class InvocableOrderTest {

    @IsTest static void priceInvocable() {
        CalculateOrderPriceInvocable.Request r = new CalculateOrderPriceInvocable.Request();
        r.listPrice = 10; r.qty = 5; r.family = 'WATER'; r.segment = 'GOLD';
        Test.startTest();
        List<CalculateOrderPriceInvocable.Response> out = CalculateOrderPriceInvocable.calculate(new List<CalculateOrderPriceInvocable.Request>{ r });
        Test.stopTest();
        System.assertNotEquals(null, out[0].unitPrice);
    }

}
