/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Test_CaseTriggerHandlerTestClass {

    @TestSetup
    static void makeData(){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Agent' LIMIT 1];
            UserRole r = [SELECT Id FROM UserRole WHERE Name = 'Agent' LIMIT 1];
            List<User> agentUsers = new List<User>();
            User testUser1 = new User(
                FirstName = 'Test',
                LastName = 'User1',
                Alias = 'tuser1',
                Email = 'testuser@example.com',
                Username = 'testuser1' + DateTime.now().getTime() + '@example.com', // Unique username
                ProfileId = p.Id,
                UserRoleId = r.Id,
                TimeZoneSidKey = 'America/New_York',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US'
            );
            agentUsers.add(testUser1);
            User testUser2 = new User(
                FirstName = 'Test',
                LastName = 'User2',
                Alias = 'tuser2',
                Email = 'testuser@example.com',
                Username = 'testuser2' + DateTime.now().getTime() + '@example.com', // Unique username
                ProfileId = p.Id,
                UserRoleId = r.Id,
                TimeZoneSidKey = 'America/New_York',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US'
            );
            agentUsers.add(testUser2);
            User testUser3 = new User(
                FirstName = 'Test',
                LastName = 'User3',
                Alias = 'tuser3',
                Email = 'testuser@example.com',
                Username = 'testuser3' + DateTime.now().getTime() + '@example.com', // Unique username
                ProfileId = p.Id,
                UserRoleId = r.Id,
                TimeZoneSidKey = 'America/New_York',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US'
            );
            agentUsers.add(testUser3);
            User testUser4 = new User(
                FirstName = 'Test',
                LastName = 'User4',
                Alias = 'tuser4',
                Email = 'testuser@example.com',
                Username = 'testuser4' + DateTime.now().getTime() + '@example.com', // Unique username
                ProfileId = p.Id,
                UserRoleId = r.Id,
                TimeZoneSidKey = 'America/New_York',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US'
            );
            agentUsers.add(testUser4);
            User testUser5 = new User(
                FirstName = 'Test',
                LastName = 'User5',
                Alias = 'tuser5',
                Email = 'testuser@example.com',
                Username = 'testuser5' + DateTime.now().getTime() + '@example.com', // Unique username
                ProfileId = p.Id,
                UserRoleId = r.Id,
                TimeZoneSidKey = 'America/New_York',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US'
            );
            agentUsers.add(testUser5);

            insert agentUsers;
    }

    @isTest
    static void myUnitTest1() {

        Profile sp = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User sysAdmin = new User(
            FirstName = 'System',
            LastName = 'Admin',
            Alias = 'sysadmin',
            Email = 'testuser@example.com',
            Username = 'sysadmin' + DateTime.now().getTime() + '@example.com', // Unique username
            ProfileId = sp.Id,
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert sysAdmin;

        System.runAs(sysAdmin){

            User testUser1 = [ Select Id from User Where FirstName = 'Test' And LastName = 'User1'];

            Test.startTest();

            List<Case> cases = new List<Case>{
                new Case(Status = 'New', Subject = 'Issue 1', Origin = 'Phone', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 2', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 3', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 4', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 5', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 6', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 7', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 8', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 9', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 10', Origin = 'Email', OwnerId = sysAdmin.Id),
                new Case(Status = 'New', Subject = 'Issue 11', Origin = 'Email', OwnerId = testUser1.Id)
            };
            insert cases;
            
            Test.stopTest();
            
            Case checkCase = [Select OwnerId From Case Where Id = :cases LIMIT 1 ];

            System.assertNotEquals(checkCase.OwnerId, sysAdmin.Id);

        }
    }

    @isTest
    static void myUnitTest2() {

        Profile sp = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User sysAdmin = new User(
            FirstName = 'System',
            LastName = 'Admin',
            Alias = 'sysadmin',
            Email = 'testuser@example.com',
            Username = 'sysadmin' + DateTime.now().getTime() + '@example.com', // Unique username
            ProfileId = sp.Id,
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert sysAdmin;

        System.runAs(sysAdmin){

            User testUser1 = [ Select Id from User Where FirstName = 'Test' And LastName = 'User1'];

            Test.startTest();

            Case case1 = new Case(
                Status = 'New', 
                Subject = 'Issue 21', 
                Origin = 'Phone', 
                OwnerId = sysAdmin.Id            
            );
            insert case1;

            Case checkCase1 = [Select OwnerId From Case Where Id = :case1.id LIMIT 1 ];
            System.debug('CheckCase1 OwnerId: ' + checkCase1.OwnerId);


            Case case2 = new Case(
                Status = 'New', 
                Subject = 'Issue 22', 
                Origin = 'Phone', 
                OwnerId = sysAdmin.Id            
            );
            insert case2;

            Case checkCase2 = [Select OwnerId From Case Where Id = :case2.id LIMIT 1 ];
            System.debug('CheckCase2 OwnerId: ' + checkCase2.OwnerId);


            Case case3 = new Case(
                Status = 'New', 
                Subject = 'Issue 23', 
                Origin = 'Phone', 
                OwnerId = sysAdmin.Id            
            );
            insert case3;
            
            Case checkCase3 = [Select OwnerId From Case Where Id = :case3.id LIMIT 1 ];
            System.debug('CheckCase3 OwnerId: ' + checkCase3.OwnerId);

            Case case4 = new Case(
                Status = 'New', 
                Subject = 'Issue 24', 
                Origin = 'Phone', 
                OwnerId = sysAdmin.Id            
            );
            insert case4;

            Case checkCase4 = [Select OwnerId From Case Where Id = :case4.id LIMIT 1 ];
            System.debug('CheckCase4 OwnerId: ' + checkCase4.OwnerId);

            Case case5 = new Case(
                Status = 'New', 
                Subject = 'Issue 25', 
                Origin = 'Phone', 
                OwnerId = sysAdmin.Id            
            );
            insert case5;
            
            Test.stopTest();
            
            Case checkCase5 = [Select OwnerId From Case Where Id = :case5.id LIMIT 1 ];
            System.debug('CheckCase5 OwnerId: ' + checkCase5.OwnerId);

            System.assertNotEquals(checkCase5.OwnerId, sysAdmin.Id);

        }
    }

    @isTest
    static void myUnitTest3() {

        Profile sp = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User sysAdmin = new User(
            FirstName = 'System',
            LastName = 'Admin',
            Alias = 'sysadmin',
            Email = 'testuser@example.com',
            Username = 'sysadmin' + DateTime.now().getTime() + '@example.com', // Unique username
            ProfileId = sp.Id,
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert sysAdmin;

        System.runAs(sysAdmin){

            User testUser1 = [ Select Id from User Where FirstName = 'Test' And LastName = 'User1'];

            Test.startTest();

            Case case1 = new Case(
                Status = 'New', 
                Subject = 'Issue 21', 
                Origin = 'Phone', 
                OwnerId = testUser1.Id            
            );
            insert case1;
            Test.stopTest();

            List<Test_QueryManager.agentCases> cases = Test_QueryManager.getCases();

            System.assertNotEquals(0 , cases.size());

        }
    }
}