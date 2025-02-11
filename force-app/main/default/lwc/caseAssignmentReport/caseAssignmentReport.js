import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getCases from '@salesforce/apex/Test_QueryManager.getCases';

const Columns =[
    { label: 'Agent Name', fieldName: 'OwnerName'},
    { label: 'Case Number', fieldName: 'CaseNumber'},
    { label: 'Status', fieldName: 'Status'}
];

export default class CaseAssignmentReport extends LightningElement {
    caseList = [];
    error;
    columns = Columns;

    @wire(getCases,{})
        wiredAgentUsers({ error, data }) {
            if (data) {
                this.caseList = data;
                this.error = undefined;
            } else if (error) {
                this.error = error;
                this.caseList = undefined;
                
            }
        }
}