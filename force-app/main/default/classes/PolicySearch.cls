public with sharing class PolicySearch
{
@AuraEnabled(cacheable=true)
 public static list<SObject> getPolicyList(String searchKey){
 string searchKeyword = '%' + searchKey + '%';
 
     string projectname = '';
        
        list<Employee__c> employeeproj = new list<Employee__c>();
        list<SObject> projpolicy = new list<SObject>();
        
        employeeproj = [Select id,Project__r.Name From Employee__c WHERE Employee_ID__c LIKE : searchKeyword];
        
        projectname = employeeproj.get(0).Project__r.Name;
        
         for(Project_Policy__c polObj : [Select id, Project__r.Name,Name, Policy_Number__c, Status__c from Project_Policy__c where Project__r.Name =:projectname]){
           projpolicy.add(polObj);
        }
        
         if(projpolicy.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
        return projpolicy;
        
        }
        }