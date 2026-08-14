/**
 * MIGRATION: A — scheduled-triggered Flow candidate.
 */
public with sharing class BeatPlanningScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        List<Beat__c> beats = [SELECT Id, Day_of_Week__c FROM Beat__c WHERE Status__c = 'Active'];
        String dow = Datetime.now().format('EEEE');
        List<Outlet__c> outlets = [SELECT Id, Beat__c FROM Outlet__c WHERE Beat__c IN :beats];
        List<Beat_Visit__c> visits = new List<Beat_Visit__c>();
        for (Outlet__c o : outlets) {
            visits.add(new Beat_Visit__c(Beat__c = o.Beat__c, Outlet__c = o.Id, Visit_Date__c = Date.today(), Status__c = 'Planned'));
        }
        if (!visits.isEmpty()) insert visits;
    }
}
