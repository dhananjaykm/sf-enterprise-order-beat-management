public with sharing class NotifyRepInvocable {
    public class Request { @InvocableVariable public Id orderId; @InvocableVariable public String subject; }
    @InvocableMethod(label='Notify Order Rep')
    public static void notify(List<Request> reqs) {
        List<Task> tasks = new List<Task>();
        for (Request r : reqs) tasks.add(new Task(Subject = r.subject, WhatId = r.orderId, Status = 'Not Started', ActivityDate = Date.today()));
        insert tasks;
    }
}
