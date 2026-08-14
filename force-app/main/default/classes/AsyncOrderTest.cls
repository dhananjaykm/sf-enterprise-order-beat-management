@IsTest
private class AsyncOrderTest {

    @IsTest static void batchAndSchedules() {
        Test.startTest();
        Database.executeBatch(new OrderReconciliationBatch(), 50);
        System.schedule('night-recon', '0 0 2 * * ?', new NightlyReconScheduler());
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM CronTrigger WHERE CronJobDetail.Name = 'night-recon']);
    }

}
