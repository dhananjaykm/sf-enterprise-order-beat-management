/**
 * MIGRATION: A — custom notification / email alert.
 */
public with sharing class OrderNotificationService {

    public static void notify(List<Order> orders) {
        List<Task> tasks = new List<Task>();
        for (Order o : orders) {
            tasks.add(new Task(Subject = 'Order update', WhatId = o.Id, Status = 'Not Started', ActivityDate = Date.today()));
        }
        if (!tasks.isEmpty()) insert tasks;
    }

}
