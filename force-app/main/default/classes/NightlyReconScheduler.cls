public with sharing class NightlyReconScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new OrderReconciliationBatch(), 100);
    }
}
