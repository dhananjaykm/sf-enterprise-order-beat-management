@IsTest
private class InventoryServiceTest {

    @IsTest static void zeroQtyTask() {
        Account a = TestDataFactory.createAccount('A3');
        Beat__c b = TestDataFactory.createBeat();
        Outlet__c o = TestDataFactory.createOutlet(b.Id, a.Id);
        Test.startTest();
        Inventory_Snapshot__c s = new Inventory_Snapshot__c(Outlet__c = o.Id, Quantity__c = 0, Snapshot_Date__c = Date.today());
        insert s;
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Task WHERE WhatId = :s.Id]);
    }

}
