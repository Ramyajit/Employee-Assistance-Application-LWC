public with sharing class customSearchEmployeeLWC {
@AuraEnabled(cacheable=true)
    public static list<Employee__c> getEmployeeList(string searchKey) {
        string searchKeyword = '%' + searchKey + '%';
        
       
        list<Employee__c> employeeListRecord = new list<Employee__c>();
     
       
        for(Employee__c empObj : [Select id,Name,Employee_ID__c,Months_of_Experience__c,Primary_Skill__c,Secondary_Skill__c,Supervisor__c,Phone__c,Email__c
From Employee__c WHERE Employee_ID__c LIKE : searchKeyword]){
           employeeListRecord.add(empObj);
        }
        
         if(employeeListRecord.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
         
        return employeeListRecord;
    }
}