/**
 * MIGRATION: B — Flow orchestrates; ERPOrderService remains invocable.
 */
public with sharing class OrderSubmissionService {

    public static void submit(List<Order> orders) {
        List<Order_Submitted__e> events = new List<Order_Submitted__e>();
        for (Order o : orders) {
            if (o.Credit_Check_Status__c != 'Pass' && o.Credit_Check_Status__c != 'Override') continue;
            o.Submission_Status__c = 'Submitted';
            ERPOrderService.queue(o);
            events.add(new Order_Submitted__e(Order_Id__c = String.valueOf(o.Id), Outlet_Id__c = String.valueOf(o.Outlet__c), Amount__c = o.TotalAmount));
        }
        if (!events.isEmpty()) EventBus.publish(events);
    }

}
