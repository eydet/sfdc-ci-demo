public with sharing class JobApplicationTriggerBL {
	
	public static void closePositionOnHire(List<Job_Application__c> newJobApplications, Map<Id, Job_Application__c> oldJobApplicationsMap){
		Boolean isInsert = false;
		Set<Id> positionIds = new Set<Id>();
		List<Position__c> associatedPositions = new List<Position__c>();
		 
		if(oldJobApplicationsMap==null){
			isInsert = true;
		}
		
		for(Job_Application__c newJobApplication : newJobApplications){
			if(newJobApplication.Picklist__c == 'Hired' && newJobApplication.Position__c != null){
				if(isInsert){
					positionIds.add(newJobApplication.Position__c);
				} else if(newJobApplication.Picklist__c != oldJobApplicationsMap.get(newJobApplication.Id).Picklist__c){
					positionIds.add(newJobApplication.Position__c);
				}
			}
		}
		
		if(positionIds.size()>0){
			associatedPositions = [SELECT 
									   p.Id,
			                           p.Status__c, 
			                           p.Close_Date__c 
			                       FROM 
			                       	   Position__c p
			                       WHERE 
			                           p.Id IN :positionIds];
		}
		
		if(associatedPositions.size()>0){
			for(Position__c associatedPosition:associatedPositions){
				associatedPosition.Close_Date__c = Date.today();
				associatedPosition.Status__c = 'Closed - Filled';
			}
			update associatedPositions;
		}
	}
}