trigger OrderApprovalTrigger on Order_Approval__c (after update) {
    Set<Id> orderIds = new Set<Id>();
    for (Order_Approval__c a : Trigger.new) {
        Order_Approval__c oldA = Trigger.oldMap.get(a.Id);
        if (oldA.Status__c != 'Approved' && a.Status__c == 'Approved') orderIds.add(a.Order__c);
    }
    List<Order> orders = [SELECT Id, Submission_Status__c FROM Order WHERE Id IN :orderIds];
    for (Order o : orders) o.Submission_Status__c = 'Approved';
    if (!orders.isEmpty()) update orders;
}
