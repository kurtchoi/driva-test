/**
 * @description       : 
 * @author            : KurtChoi
 * @group             : 
 * @last modified on  : 02-12-2025
 * @last modified by  : KurtChoi
**/
public with sharing class Test_CaseTriggerHandler {
    public static void caseAssignment(List<Case> cases) {
        List<Case> caseToUpdate = new List<Case>();
        List<User> agentUsers = [Select Id from User Where UserRole.Name = 'Agent' And IsActive = true];
        List<Id> agentUsersId = new List<Id>();
        for(User user : agentUsers){
            agentUsersId.add(user.Id);
        }
        List<Case> caseOwner = [Select Id, OwnerId from Case];
        Map<Id, Integer> caseAssignmentMap = new Map<Id, Integer>();

        for(User mapAgent: agentUsers){
            caseAssignmentMap.put(mapAgent.Id, 0);
        }

        for(Case caseAssignment : caseOwner){
            for(Id counts : caseAssignmentMap.keySet()) {
                if(counts == caseAssignment.OwnerId){
                    caseAssignmentMap.put(counts, caseAssignmentMap.get(counts)+1);
                }
            }
        }

        for(Case assignCase: cases){
            Map<Id, Integer> sortedcaseAssignmentMap = new Map<Id, Integer>();
            List<Id> sortedcaseMapId = new List<Id>();
            sortedcaseMapId = sortCaseAssignmentMap(caseAssignmentMap);
            if(!sortedcaseMapId.isEmpty()){
                caseAssignmentMap.put(sortedcaseMapId[0], caseAssignmentMap.get(sortedcaseMapId[0])+1);
                Case updatedCase = new Case(Id = assignCase.Id, OwnerId = sortedcaseMapId[0]);
                caseToUpdate.add(updatedCase);
            }
        }
        update caseToUpdate;

    }
    public static List<Id> sortCaseAssignmentMap(Map<Id, Integer> caseAssignmentMap){
        List<Id> caseMapId = new List<Id>();
        Map<Id, Integer> newCaseAssignmentMap = new Map<Id, Integer>();
        for(Id caseMap: caseAssignmentMap.keySet()){
            caseMapId.add(caseMap);
        }
        for(integer i = 0; i<caseMapId.size(); i++){
            for(integer j = 0; j<caseMapId.size()-1-i; j++){
                if( caseAssignmentMap.get(caseMapId[j]) >= caseAssignmentMap.get(caseMapId[j+1])){
                    Id storeId = caseMapId[j];
                    caseMapId[j] = caseMapId[j+1];
                    caseMapId[j+1] = storeId;
                }
            }       
        }
        return caseMapId;
    }
}