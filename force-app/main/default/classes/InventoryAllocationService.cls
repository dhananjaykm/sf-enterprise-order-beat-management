/**
 * MIGRATION: E — warehouse allocation algorithm.
 */
public with sharing class InventoryAllocationService {

    public static Map<Id, String> allocate(List<Order> orders) {
        Map<Id, String> warehouse = new Map<Id, String>();
        for (Order o : orders) {
            warehouse.put(o.Id, Math.mod(Crypto.getRandomInteger(), 2) == 0 ? 'WH-NORTH' : 'WH-SOUTH');
        }
        return warehouse;
    }

}
