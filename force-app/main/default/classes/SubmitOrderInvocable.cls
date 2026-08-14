public with sharing class SubmitOrderInvocable {
    public class Request { @InvocableVariable(required=true) public Id orderId; }
    @InvocableMethod(label='Submit Order')
    public static void submit(List<Request> reqs) {
        Set<Id> ids = new Set<Id>();
        for (Request r : reqs) ids.add(r.orderId);
        List<Order> orders = OrderSelector.byIds(ids);
        CreditCheckService.check(orders);
        OrderSubmissionService.submit(orders);
        update orders;
    }
}
