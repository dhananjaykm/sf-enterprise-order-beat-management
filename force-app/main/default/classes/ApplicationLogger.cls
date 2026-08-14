/**
 * Centralized debug/audit logger. Writes Application_Log__c when available.
 * MIGRATION: E — keep Apex. Logging is a platform concern, not Flow.
 */
public with sharing class ApplicationLogger {
    public enum Level { DEBUG_X, INFO, WARN, ERROR }

    public static void info(String source, String message) {
        write(Level.INFO, source, message, null);
    }

    public static void warn(String source, String message) {
        write(Level.WARN, source, message, null);
    }

    public static void error(String source, String message, Exception ex) {
        write(Level.ERROR, source, message, ex);
    }

    public static void write(Level lvl, String source, String message, Exception ex) {
        String payload = source + ' | ' + String.valueOf(lvl) + ' | ' + message;
        if (ex != null) {
            payload += ' | ' + ex.getMessage() + ' | ' + ex.getStackTraceString();
        }
        System.debug(LoggingLevel.INFO, payload);
        try {
            if (Schema.getGlobalDescribe().containsKey('Application_Log__c')) {
                SObject logRow = Schema.getGlobalDescribe().get('Application_Log__c').newSObject();
                logRow.put('Source__c', source != null && source.length() > 80 ? source.substring(0, 80) : source);
                logRow.put('Level__c', String.valueOf(lvl));
                logRow.put('Message__c', payload != null && payload.length() > 32768 ? payload.substring(0, 32768) : payload);
                insert logRow;
            }
        } catch (Exception ignore) {
            System.debug(LoggingLevel.ERROR, 'ApplicationLogger failed: ' + ignore.getMessage());
        }
    }
}
