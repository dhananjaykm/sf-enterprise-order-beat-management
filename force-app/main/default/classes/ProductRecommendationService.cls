/**
 * MIGRATION: D — must-stock list is Flow Get Records; ranking stays Apex.
 */
public with sharing class ProductRecommendationService {

    public static List<Outlet_Product__c> recommend(Id outletId) {
        return [SELECT Id, Product__c, Must_Stock__c, Last_Qty__c FROM Outlet_Product__c WHERE Outlet__c = :outletId ORDER BY Must_Stock__c DESC, Last_Qty__c ASC LIMIT 20];
    }

}
