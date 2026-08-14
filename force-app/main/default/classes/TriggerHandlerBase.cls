/**
 * Legacy trigger dispatcher used across objects.
 * Mixed with direct-utility trigger calls elsewhere (intentional technical debt).
 *
 * MIGRATION: G — framework code should not become Flow.
 */
public virtual with sharing class TriggerHandlerBase {
    public static Boolean bypassTriggers = false;

    public virtual void beforeInsert(List<SObject> newList) {}
    public virtual void afterInsert(List<SObject> newList) {}
    public virtual void beforeUpdate(List<SObject> newList, Map<Id, SObject> oldMap) {}
    public virtual void afterUpdate(List<SObject> newList, Map<Id, SObject> oldMap) {}
    public virtual void beforeDelete(Map<Id, SObject> oldMap) {}
    public virtual void afterDelete(Map<Id, SObject> oldMap) {}
    public virtual void afterUndelete(List<SObject> newList) {}

    public void run(
        Boolean isBefore,
        Boolean isAfter,
        Boolean isInsert,
        Boolean isUpdate,
        Boolean isDelete,
        Boolean isUndelete,
        List<SObject> newList,
        Map<Id, SObject> oldMap
    ) {
        if (bypassTriggers) {
            return;
        }
        if (isBefore && isInsert) {
            beforeInsert(newList);
        } else if (isAfter && isInsert) {
            afterInsert(newList);
        } else if (isBefore && isUpdate) {
            beforeUpdate(newList, oldMap);
        } else if (isAfter && isUpdate) {
            afterUpdate(newList, oldMap);
        } else if (isBefore && isDelete) {
            beforeDelete(oldMap);
        } else if (isAfter && isDelete) {
            afterDelete(oldMap);
        } else if (isAfter && isUndelete) {
            afterUndelete(newList);
        }
    }
}
