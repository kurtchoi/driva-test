/**
 * @description       : 
 * @author            : KurtChoi
 * @group             : 
 * @last modified on  : 02-12-2025
 * @last modified by  : KurtChoi
**/
public with sharing class Test_QueryManager {
    
    public class agentCases {
        @AuraEnabled public String OwnerName;
        @AuraEnabled public String CaseNumber;
        @AuraEnabled public String Status;
    }

    @AuraEnabled(cacheable=true)
    public static List<agentCases> getCases() {
        List<Case> caseList = [Select Id, Status, Owner.Name, CaseNumber From Case Where Owner.IsActive = True And Owner.UserRole.Name = 'Agent'];
        List<agentCases> agentCasesList = new List<AgentCases>();

        for(Case eachCase: caseList) {
            agentCases agentCase = new agentCases();
            agentCase.CaseNumber = eachCase.CaseNumber;
            agentCase.Status = eachCase.Status;
            agentCase.OwnerName = eachCase.Owner.Name;
            agentCasesList.add(agentCase);
        }

        return agentCasesList;
    }
}