public with sharing class PaymentCaptureQueueable implements Queueable {
    private Set<Id> paymentIds;
    public PaymentCaptureQueueable(Set<Id> paymentIds) { this.paymentIds = paymentIds; }
    public void execute(QueueableContext ctx) {
        List<Payment__c> pays = [SELECT Id, Status__c FROM Payment__c WHERE Id IN :paymentIds];
        for (Payment__c p : pays) if (p.Status__c == 'Pending') p.Status__c = 'Captured';
        update pays;
    }
}
