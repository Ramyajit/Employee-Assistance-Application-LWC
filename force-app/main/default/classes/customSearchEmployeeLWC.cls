/*
Description : Class to find the Employee(s) corresponding to the Employee Id, entered by the user in the Search Box of the Employee Tab*/

public with sharing class customSearchEmployeeLWC {
@AuraEnabled(cacheable=true)
    public static list<Employee__c> getEmployeeList(string searchKey) {
        string searchKeyword = '%' + searchKey + '%';
        
       
        list<Employee__c> employeeListRecord = new list<Employee__c>();
     

     //Searching for the all the employees with the similar sequence of Employee ID or The exact Employee
       
        for(Employee__c empObj : [Select id,Name,Employee_ID__c,Months_of_Experience__c,Primary_Skill__c,Secondary_Skill__c,Supervisor__c,Phone__c,Email__c
From Employee__c WHERE Employee_ID__c LIKE : searchKeyword]){
           employeeListRecord.add(empObj);
        }
        
         if(employeeListRecord.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
         
        return employeeListRecord; // returing the list of employee(s) back to the LWC, so it can be displayed in the Employee Tab
    }
}