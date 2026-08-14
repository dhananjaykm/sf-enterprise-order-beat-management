/**
 * MIGRATION: A — status updates + scheduled path 7-day follow-up.
 */
public with sharing class OrderFulfillmentService {

    public static void markDelivered(List<Order> orders) {
        for (Order o : orders) {
            if (o.Submission_Status__c == 'Fulfilled' && o.Delivered_On__c == null) {
                o.Delivered_On__c = Date.today();
            }
        }
    }

    public static Integer createFollowups(Date deliveredOn) {
        Date cutoff = deliveredOn.addDays(-7);
        List<Order> due = [SELECT Id, AccountId, Followup_Task_Created__c FROM Order
                           WHERE Delivered_On__c <= :cutoff AND Followup_Task_Created__c = false AND Submission_Status__c = 'Fulfilled' LIMIT 200];
        List<Task> tasks = new List<Task>();
        for (Order o : due) {
            o.Followup_Task_Created__c = true;
            tasks.add(new Task(Subject = 'Customer follow-up', WhatId = o.Id, ActivityDate = Date.today(), Status = 'Not Started'));
        }
        if (!due.isEmpty()) update due;
        if (!tasks.isEmpty()) insert tasks;
        return due.size();
    }

}
