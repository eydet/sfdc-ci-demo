trigger JobApplicationTrigger on Job_Application__c (after insert, after update) {
	
	if(trigger.isAfter){
		if(trigger.isInsert){
			JobApplicationTriggerBL.closePositionOnHire(trigger.new, null);
		}
		if(trigger.isUpdate){
			JobApplicationTriggerBL.closePositionOnHire(trigger.new, trigger.oldMap);
		}
	}

}