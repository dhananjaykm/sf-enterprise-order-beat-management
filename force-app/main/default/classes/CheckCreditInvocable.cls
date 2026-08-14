public with sharing class CheckCreditInvocable {
    public class Request { @InvocableVariable(required=true) public Id orderId; }
    public class Response { @InvocableVariable public String status; }
    @InvocableMethod(label='Check Credit')
    public static List<Response> check(List<Request> reqs) {
        Set<Id> ids = new Set<Id>();
        for (Request r : reqs) ids.add(r.orderId);
        List<Order> orders = OrderSelector.byIds(ids);
        CreditCheckService.check(orders);
        List<Response> out = new List<Response>();
        for (Order o : orders) { Response x = new Response(); x.status = o.Credit_Check_Status__c; out.add(x); }
        return out;
    }
}
