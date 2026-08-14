public with sharing class CreateERPOrderInvocable {
    public class Request { @InvocableVariable(required=true) public Id orderId; }
    public class Response { @InvocableVariable public Id erpOrderId; }
    @InvocableMethod(label='Create ERP Order')
    public static List<Response> createRows(List<Request> reqs) {
        List<ERP_Order__c> rows = new List<ERP_Order__c>();
        for (Request r : reqs) rows.add(new ERP_Order__c(Order__c = r.orderId, Status__c = 'Queued'));
        insert rows;
        List<Response> out = new List<Response>();
        for (ERP_Order__c row : rows) { Response x = new Response(); x.erpOrderId = row.Id; out.add(x); }
        return out;
    }
}
