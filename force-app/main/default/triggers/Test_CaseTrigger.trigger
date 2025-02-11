/**
 * @description       : 
 * @author            : KurtChoi
 * @group             : 
 * @last modified on  : 02-11-2025
 * @last modified by  : KurtChoi
**/
trigger Test_CaseTrigger on Case (after insert) {

    if(Trigger.isInsert){
        Test_CaseTriggerHandler.caseAssignment(Trigger.New);
    }
}