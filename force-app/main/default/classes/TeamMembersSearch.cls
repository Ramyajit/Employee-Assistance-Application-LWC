public with sharing class TeamMembersSearch
{
@AuraEnabled(cacheable=true)
    public static list<SObject> getRelatedEmployeeList(string searchKey) {
        string searchKeyword = '%' + searchKey + '%';
        
        string projectname = '';
        
        list<Employee__c> employeeproj = new list<Employee__c>();
        list<SObject> employeelist= new list<SObject>();
        
        employeeproj = [Select id,Project__r.Name From Employee__c WHERE Employee_ID__c LIKE : searchKeyword];
        
        projectname = employeeproj.get(0).Project__r.Name;
        
         for(Employee__c empObj : [Select id, Project__r.Name,Name, Employee_ID__c,Months_of_Experience__c,Primary_Skill__c,Secondary_Skill__c,Supervisor__c,Phone__c,Email__c from Employee__c where Project__r.Name =:projectname]){
           employeelist.add(empObj);
        }

       /* private static string proj = projectname;

        public static String ProjectName(){
            return proj;
        }*/

        
         if(employeelist.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
        return employeelist;
        
        }
        }