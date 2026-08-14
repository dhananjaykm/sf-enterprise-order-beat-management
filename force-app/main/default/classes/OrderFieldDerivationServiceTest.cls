@IsTest
private class OrderFieldDerivationServiceTest {

    @IsTest static void derivesBeatAndSegment() {
        Account a = TestDataFactory.createAccount('A1');
        Beat__c b = TestDataFactory.createBeat();
        Outlet__c o = TestDataFactory.createOutlet(b.Id, a.Id);
        Order ord = new Order(AccountId = a.Id, EffectiveDate = Date.today(), Status = 'Draft', Outlet__c = o.Id);
        Test.startTest();
        insert ord;
        Test.stopTest();
        Order stored = [SELECT Beat__c, Customer_Segment__c FROM Order WHERE Id = :ord.Id];
        System.assertEquals(b.Id, stored.Beat__c);
        System.assertEquals('GOLD', stored.Customer_Segment__c);
    }

}
