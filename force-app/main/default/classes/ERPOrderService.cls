/**
 * MIGRATION: C — Invocable Apex callout. OAuth stays Apex.
 */
public with sharing class ERPOrderService {

    public static String authenticate() {
        ERP_Settings__c s = ERP_Settings__c.getInstance();
        HttpRequest req = new HttpRequest();
        req.setEndpoint((s != null && s.Endpoint__c != null ? s.Endpoint__c : 'https://example.invalid/erp') + '/oauth/token');
        req.setMethod('POST');
        req.setBody('grant_type=client_credentials');
        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() >= 300) {
            throw new IntegrationException('ERP auth failed ' + res.getStatus());
        }
        return 'mock-token';
    }

    public static void queue(Order o) {
        insert new ERP_Order__c(Order__c = o.Id, Status__c = 'Queued', Payload__c = '{"orderId":"' + o.Id + '"}', Retry_Count__c = 0);
    }

}
