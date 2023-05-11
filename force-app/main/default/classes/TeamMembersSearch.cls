/*
Description : Class to Find out the employees, belonging to the same project, and returning that list to be displayed in the Employee Teams Tab*/
public with sharing class TeamMembersSearch
{
@AuraEnabled(cacheable=true)
    public static list<SObject> getRelatedEmployeeList(string searchKey) {
        string searchKeyword = '%' + searchKey + '%';
        
        string projectname = '';
        
        list<Employee__c> employeeproj = new list<Employee__c>();
        list<SObject> employeelist= new list<SObject>();

        //Finding out the Project of the Employee, whose Employee ID, the User is entering, in the Second Employee Teams Tab.
        
        employeeproj = [Select id,Project__r.Name From Employee__c WHERE Employee_ID__c LIKE : searchKeyword];
        
        projectname = employeeproj.get(0).Project__r.Name;
        
        //Finding out the list of the employees who belong to the same project, as the employee, for whom the User is searching.

         for(Employee__c empObj : [Select id, Project__r.Name,Name, Employee_ID__c,Months_of_Experience__c,Primary_Skill__c,Secondary_Skill__c,Supervisor__c,Phone__c,Email__c from Employee__c where Project__r.Name =:projectname]){
           employeelist.add(empObj);
        }

         if(employeelist.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
        return employeelist; // returing the list of employee(s) that belong to the same project, back to the LWC, so it can be displayed in the Employee Teams Tab
        
        }
        }