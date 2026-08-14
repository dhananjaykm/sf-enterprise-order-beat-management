public with sharing class TargetRecalcQueueable implements Queueable {
    public void execute(QueueableContext ctx) {
        ApplicationLogger.info('TargetRecalcQueueable', 'noop recalc');
    }
}
