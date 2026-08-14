public with sharing class OrderTriggerHandler extends TriggerHandlerBase {
    public override void beforeInsert(List<SObject> newList) {
        List<Order> orders = (List<Order>) newList;
        OrderFieldDerivationService.derive(orders);
        OrderPricingService.applySimpleDiscount(orders);
        OrderValidationService.validate(orders);
    }
    public override void beforeUpdate(List<SObject> newList, Map<Id, SObject> oldMap) {
        OrderFieldDerivationService.derive((List<Order>) newList);
        CreditCheckService.check((List<Order>) newList);
    }
    public override void afterUpdate(List<SObject> newList, Map<Id, SObject> oldMap) {
        List<Order> orders = (List<Order>) newList;
        Map<Id, Order> oldOrders = new Map<Id, Order>();
        for (Id i : oldMap.keySet()) oldOrders.put(i, (Order) oldMap.get(i));
        OrderApprovalService.requestIfNeeded(orders, oldOrders);
        OrderFulfillmentService.markDelivered(orders);
        OrderAuditService.audit('afterUpdate', orders.size());
    }
}
