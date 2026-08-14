public with sharing class OutletSelector {
    public static Map<Id, Outlet__c> byIds(Set<Id> ids) {
        return new Map<Id, Outlet__c>([
            SELECT Id, Account__c, Beat__c, Segment__c, Credit_Limit__c, Open_AR__c, Risk_Flag__c, Channel__c
            FROM Outlet__c WHERE Id IN :ids
        ]);
    }
}
