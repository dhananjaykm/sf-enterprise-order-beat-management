/**
 * MIGRATION: D — FIFO allocation is Apex; failed-payment side effects are Flow.
 */
public with sharing class PaymentAllocationService {

    public static void allocate(List<Payment__c> payments) {
        for (Payment__c p : payments) {
            if (p.Status__c == 'Failed' && p.Outlet__c != null) {
                // related updates happen in PaymentFailureService
            }
        }
    }

}
