@isTest
private class UsePermissionInTestClass {
   @testsetup
    public static void insertAccountTestData(){
            Account a = new Account();
            a.Name = 'Test';
            a.Phone = '1233567890';
            a.Rating = 'cold';
            insert a;
    }
	@istest
    public static void accountRecordsInsert(){
		system.debug('@@@@@ '+ [SELECT Id FROM Account].size());
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User Cloned'].Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            UserName = 'Cpt.Awesome.' + DateTime.now().getTime() + '@awesomesauce.com',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;
        permissionset ps = [Select Id from Permissionset where Name = 'Standard_User_Test_Class_Permission_set'];
        PermissionSetAssignment psa =  new PermissionSetAssignment();
            psa.AssigneeId = u.id;
            psa.PermissionSetId = ps.Id;
        insert psa;
        system.runAs(u){
            Test.startTest();
            Account[] pos = [SELECT Id FROM Account];
            pos[0].Name = 'test account';
            update pos;'Cold';
            insert a;
            Test.stopTest();
            // THEN
            Assert.areEqual(
                1,
                pos.size(),
                'A user without the permission set shouldn\'t see any records');
        }
        
    }
}