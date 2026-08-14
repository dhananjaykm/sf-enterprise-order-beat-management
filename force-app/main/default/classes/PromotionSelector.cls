public with sharing class PromotionSelector {
    public static List<Promotion__c> active() {
        Date today = Date.today();
        return [SELECT Id, Name, Start_Date__c, End_Date__c, Stackable__c,
                       (SELECT Id, Min_Qty__c, Discount_Percent__c, Product_Family__c FROM Rules__r)
                FROM Promotion__c WHERE Is_Active__c = true AND Start_Date__c <= :today AND End_Date__c >= :today];
    }
}
