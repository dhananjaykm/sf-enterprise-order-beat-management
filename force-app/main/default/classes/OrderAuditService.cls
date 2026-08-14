/**
 * MIGRATION: E — retain logging Apex.
 */
public with sharing class OrderAuditService {

    public static void audit(String action, Integer count) {
        ApplicationLogger.info('OrderAuditService', action + ':' + count);
    }

}
