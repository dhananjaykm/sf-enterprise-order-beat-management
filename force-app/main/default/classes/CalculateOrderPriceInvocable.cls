public with sharing class CalculateOrderPriceInvocable {
    public class Request { @InvocableVariable public Decimal listPrice; @InvocableVariable public Integer qty; @InvocableVariable public String family; @InvocableVariable public String segment; }
    public class Response { @InvocableVariable public Decimal unitPrice; }
    @InvocableMethod(label='Calculate Order Price')
    public static List<Response> calculate(List<Request> reqs) {
        List<Response> out = new List<Response>();
        for (Request r : reqs) {
            Response x = new Response();
            x.unitPrice = PricingEngine.compute(r.listPrice, r.qty, r.family, r.segment);
            out.add(x);
        }
        return out;
    }
}
