Components Created:

Triggers:
Test_CaseTrigger

Apex:
Test_CaseTriggerHandler
Test_CaseTriggerHandlerTestClass
Test_QueryManager

LWC:
caseAssignmentReport.html
caseAssignmentReport.js
caseAssignmentReport.js-meta.xml
caseAssignmentReport.css


Configurations:
1. Disabled Case Assignment Rule "Standard"
2. Added LWC Component in Home Page
3. Create 5 Test Users
4. Deactivate existing Users. ( Larry Ross, Ashton Haynes, Amaan Strickland)

Solution Approach:

Round Robin Assignment - 
- Test_CaseTrigger Trigger was created in order to capture any Insert of Case Records, Trigger will then pass the data of the newly inserted record to Test_CaseTrigger.caseAssignment method.
- Test_CaseTrigger.caseAssignment is used to assign the case in a Round Robin Assignment, with consideration to whether Record is being uploaded in bulk or uploaded manually
    - Method will first retrieve all active Agent users and all Cases
    - A map containing the count of casses assigned to all active Agent Users will be created.
    - This Map will then be sorted in the order of the Least number of assigned case.
    - Assuming that all agents are not assigned to any case yet, cases will be assigned evenly to each one of themselves
    - In case that there are other Agents that are already having existing cases, agents without cases or least cases will be prioritized for the assignment.

LwC Report -
- caseAssignmentReport Custom LwC component is created in order to show a table consisting of Case records along with the Owner, CaseNumber, and Status.
- @wire was used to call Test_QueryManager.getCases Apex Method.
    - Test_QueryManager.getCases is used to retrieve all cases owned by Agents
- Data recieved from getCases is then assigned to caseList which will be used by the html file to render the data.


Testing -
1. Manual Creation of Case through record page
2. Verify distribution of cases through LwC component in Home Page
