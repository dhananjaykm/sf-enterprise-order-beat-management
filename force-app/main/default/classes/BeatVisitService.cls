/**
 * MIGRATION: A — record-triggered Flow on Beat_Visit__c.
 */
public with sharing class BeatVisitService {

    public static void startVisit(List<Beat_Visit__c> visits) {
        for (Beat_Visit__c v : visits) {
            if (v.Status__c == 'Planned') {
                v.Status__c = 'Started';
                v.Started_At__c = Datetime.now();
            }
        }
    }

}
