/*
Description : Class to Find out the policies, belonging to the same project, and returning that list to be displayed in the Policies Tab*/

public with sharing class PolicySearch
{
@AuraEnabled(cacheable=true)
 public static list<SObject> getPolicyList(String searchKey){
 string searchKeyword = '%' + searchKey + '%';
 
     string projectname = '';
        
        list<Employee__c> employeeproj = new list<Employee__c>();
        list<SObject> projpolicy = new list<SObject>();

        //Finding out the Project of the Employee, whose Employee ID, the User is entering in the Second Employee Teams Tab, which is being passed to this class by the @wire functionality of LWC.
        
        employeeproj = [Select id,Project__r.Name From Employee__c WHERE Employee_ID__c LIKE : searchKeyword];
        
        projectname = employeeproj.get(0).Project__r.Name;

        //Finding out the list of the policies tagged to the same project
        
         for(Project_Policy__c polObj : [Select id, Project__r.Name,Name, Policy_Number__c, Status__c from Project_Policy__c where Project__r.Name =:projectname]){
           projpolicy.add(polObj);
        }
        
         if(projpolicy.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
        return projpolicy; //returing the list of policies associated with a given project back to the LWC, so it can be displayed in the Policy Tab
        
        }
        }