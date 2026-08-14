trigger SalesTargetTrigger on Sales_Target__c (before insert) {
    for (Sales_Target__c t : Trigger.new) {
        if (t.Amount_Actual__c == null) t.Amount_Actual__c = 0;
    }
}
