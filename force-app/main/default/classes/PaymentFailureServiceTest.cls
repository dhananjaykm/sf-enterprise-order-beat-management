@IsTest
private class PaymentFailureServiceTest {

    @IsTest static void failedPaymentCreatesTask() {
        Account a = TestDataFactory.createAccount('A2');
        Beat__c b = TestDataFactory.createBeat();
        Outlet__c o = TestDataFactory.createOutlet(b.Id, a.Id);
        Test.startTest();
        insert new Payment__c(Outlet__c = o.Id, Amount__c = 50, Status__c = 'Failed');
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Task WHERE WhatId = :o.Id]);
        System.assertEquals(true, [SELECT Risk_Flag__c FROM Outlet__c WHERE Id = :o.Id].Risk_Flag__c);
    }

}
