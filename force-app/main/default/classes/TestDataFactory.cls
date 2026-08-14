/**
 * Shared test data factory. Tests must not use SeeAllData=true.
 */
@IsTest
public class TestDataFactory {
    public static User createUser(String alias) {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        String unique = alias + String.valueOf(Crypto.getRandomInteger());
        User u = new User(
            Alias = alias.left(8),
            Email = unique + '@example.invalid',
            EmailEncodingKey = 'UTF-8',
            LastName = alias,
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            ProfileId = p.Id,
            UserName = unique + '@example.invalid'
        );
        insert u;
        return u;
    }

    public static Account createAccount(String name) {
        Account a = new Account(Name = name);
        insert a;
        return a;
    }


    public static Beat__c createBeat() {
        Beat__c b = new Beat__c(Day_of_Week__c = 'Monday', Status__c = 'Active');
        insert b; return b;
    }
    public static Outlet__c createOutlet(Id beatId, Id accountId) {
        Outlet__c o = new Outlet__c(Name = 'Store', Beat__c = beatId, Account__c = accountId, Segment__c = 'GOLD', Credit_Limit__c = 100000, Open_AR__c = 10);
        insert o; return o;
    }

}
