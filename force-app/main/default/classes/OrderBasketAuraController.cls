/**
 * Aura Apex controller. Client-side events plus server DML.
 * MIGRATION: F — some actions are Screen Flow candidates; keep Apex for DML bulk paths.
 */
public with sharing class OrderBasketAuraController {
    @AuraEnabled
    public static List<Map<String, Object>> loadPanel(Id recordId) {
        List<Map<String, Object>> rows = new List<Map<String, Object>>();
        for (SObject rec : Database.query('SELECT Id, OrderNumber FROM Order LIMIT 20')) {
            rows.add(new Map<String, Object>{
                'id' => rec.Id,
                'name' => rec.get('Name'),
                'status' => 'Loaded'
            });
        }
        return rows;
    }

    @AuraEnabled
    public static List<Map<String, Object>> applyAction(Id recordId) {
        return loadPanel(recordId);
    }
}
