/**
 * MIGRATION: A — validation rules + Flow fault path. Keep Apex for cross-object credit.
 */
public with sharing class OrderValidationService {

    public static void validate(List<Order> orders) {
        for (Order o : orders) {
            if (o.EffectiveDate != null && o.EffectiveDate < Date.today().addDays(-7)) {
                o.addError('Effective date is too far in the past');
            }
        }
    }

}
