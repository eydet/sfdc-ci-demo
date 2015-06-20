@isTest
private class JobApplicationTriggerBL_Test {

//Comment IST 20JUL-6.15AM 
	
    static testMethod void insertJobApplication() {
    	Candidate__c newCandidate = new Candidate__c(First_Name__c='New', Last_Name__c='Candidate1', Email__c='new.candidate1@test.com');
    	insert newCandidate;
    	Position__c newPosition = new Position__c(Name='TestPosition', Min_Pay__c=1.00, Max_Pay__c=2.00,Status__c='New Position');
    	insert newPosition;
    	Job_Application__c newJobApplication = new Job_Application__c(Candidate__c=newCandidate.Id, Position__c=newPosition.Id, Picklist__c='Hired');
    	insert newJobApplication;
    	
    	Position__c insertedPosition = [SELECT
    									    Id,
    									    Status__c,
    										Close_Date__c
    								    FROM
    								        Position__c
    								    WHERE
    								        Id = :newPosition.Id];
 		
 		System.assertEquals(insertedPosition.Status__c, 'Closed - Filled');
 		System.assertEquals(insertedPosition.Close_Date__c, Date.today());
    	
    }
    
    
    static testMethod void updateJobApplication() {
    	Candidate__c newCandidate = new Candidate__c(First_Name__c='New', Last_Name__c='Candidate1', Email__c='new.candidate1@test.com');
    	insert newCandidate;
    	Position__c newPosition = new Position__c(Name='TestPosition', Min_Pay__c=1.00, Max_Pay__c=2.00,Status__c='New Position');
    	insert newPosition;
    	Job_Application__c newJobApplication = new Job_Application__c(Candidate__c=newCandidate.Id, Position__c=newPosition.Id, Picklist__c='New');
    	insert newJobApplication;
    	
    	newJobApplication.Picklist__c = 'Hired';
    	update newJobApplication;
    	
    	Position__c insertedPosition = [SELECT
    									    Id,
    									    Status__c,
    										Close_Date__c
    								    FROM
    								        Position__c
    								    WHERE
    								        Id = :newPosition.Id];
 		
 		System.assertEquals(insertedPosition.Status__c, 'Closed - Filled');
 		System.assertEquals(insertedPosition.Close_Date__c, Date.today());
    	
    }
    
    
}