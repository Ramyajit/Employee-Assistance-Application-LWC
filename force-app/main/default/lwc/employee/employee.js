import { LightningElement, track,wire,api } from 'lwc';
import getEmployeeList from '@salesforce/apex/customSearchEmployeeLWC.getEmployeeList';
import getRelatedEmployeeList from '@salesforce/apex/TeamMembersSearch.getRelatedEmployeeList';
import getPolicyList from '@salesforce/apex/PolicySearch.getPolicyList';
import { NavigationMixin } from 'lightning/navigation';

export default class CustomRecordSearch extends NavigationMixin(LightningElement) {
    @track employeesRecord;
    @track employeesRecord2;
    @track policyRecord;
    @track error;
    searchValue = '';
    @api searchValue2 ;
    tabContent = '';
    //This Funcation will get the value from Text Input from the Employee Tab.
    searchKeyword(event){
        this.searchValue = event.target.value;
    }


    //This Funcation will get the value from Text Input from the Employee Teams Tab.
    searchKeyword2(event){
        const userInput = event.target.value;
        this.searchValue2 = userInput;
    }

    //This funcation will fetch the Employee Details on basis of searchkey
    handleSearchKeyword(){
        //calling Apex method.
        getEmployeeList({searchKey: this.searchValue})
        .then(result => {
                this.employeesRecord = result;
        })
        .catch( error=>{
            this.employeesRecord = null;
        });

    }

    //This funcation will fetch the Employee Details belonging to the same Project
    handleSearchKeyword2(){
        //calling Apex method.
        getRelatedEmployeeList({searchKey: this.searchValue2})
        .then(result => {
                this.employeesRecord2 = result;
        })
        .catch( error=>{
            this.employeesRecord2 = null;
        });

    }

    //This function is passing the Employee Id from the Second Tab, to the Controller, which will fetch the Policies related to the Same Project
    @wire(getPolicyList,{searchKey: '$searchValue2'})
    policydata({error,data}){
        if(data)
        {
            this.policyRecord = data;
        }
        else if (error)
        {
            this.policyRecord = undefined;
        }
    }


    //This is the redirection of the Employee Records to their individual Edit, page opening in a form of record Page.
    navigateToEditEmployeePage(event){
        this.recordId = event.detail?.row?.Id;
    console.log('Record Id ==> '+ this.recordId);
        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                recordId: this.recordId,
                objectApiName:'Employee__c',
                actionName: 'edit'
        }
    });
}
        

    cols = [
        {label:'Employee Id', fieldName:'Employee_ID__c' , type:'text'} ,
        {label:'Employee Name', fieldName:'Name' , type:'text'} ,
        {label:'Months of Experience', fieldName:'Months_of_Experience__c' , type:'Number'} ,
        {label:'Primary Skill', fieldName:'Primary_Skill__c' , type:'Picklist'} ,
        {label:'Secondary Skill', fieldName:'Secondary_Skill__c' , type:'Picklist'} ,
        {label:'Phone', fieldName:'Phone__c' , type:'Phone'} ,
        {label:'Email', fieldName:'Email__c' , type:'Email'},
        {
            type:"button",
            fixedWidth: 150,
            typeAttributes: {
                label: 'Edit',
                name: 'edit',
                variant: 'brand'
            }
        }
              
    ]

    cols2 = [
        {label:'Employee Id', fieldName:'Employee_ID__c' , type:'text'} ,
        {label:'Employee Name', fieldName:'Name' , type:'text'} ,
        {label:'Months of Experience', fieldName:'Months_of_Experience__c' , type:'Number'} ,
        {label:'Primary Skill', fieldName:'Primary_Skill__c' , type:'Picklist'} ,
        {label:'Secondary Skill', fieldName:'Secondary_Skill__c' , type:'Picklist'} ,
        {label:'Phone', fieldName:'Phone__c' , type:'Phone'} ,
        {label:'Email', fieldName:'Email__c' , type:'Email'}
              
    ]

    cols3 = [
        {label:'Policy Name', fieldName:'Name' , type:'text'} ,
        {label:'Policy Number', fieldName:'Policy_Number__c' , type:'auto number'} ,
        {label:'Status', fieldName:'Status__c' , type:'Picklist'}
    ]



}