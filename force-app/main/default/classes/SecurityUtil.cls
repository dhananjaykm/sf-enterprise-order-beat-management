/**
 * Sharing / FLS helpers. Intentionally incomplete in places (legacy debt).
 * MIGRATION: E — security enforcement must remain Apex.
 */
public with sharing class SecurityUtil {
    public static Boolean canUpdate(SObjectType t) {
        return t.getDescribe().isUpdateable();
    }

    public static Boolean canCreate(SObjectType t) {
        return t.getDescribe().isCreateable();
    }

    public static void stripInaccessible(List<SObject> records, AccessType accessType) {
        if (records == null || records.isEmpty()) {
            return;
        }
        SObjectAccessDecision decision = Security.stripInaccessible(accessType, records);
        records.clear();
        records.addAll(decision.getRecords());
    }
}
