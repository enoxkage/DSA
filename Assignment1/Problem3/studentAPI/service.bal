import ballerina/http;
import ballerina/io;

type Students record {|
    readonly int studentNumber;
    string name;
    string email;
    map<string> courses;
|};

table<Students> key(studentNumber) studentTable = table[];

 type CreatedStudentEntries record {|
    *http:Created;
     Students[] body;
|};



service /student on new http:Listener(9090){

     resource function get students() returns Students|anydata{
        lock {
            return studentTable.clone();
        }
    }


     resource function get student/[int studentNumber]()returns Students|anydata {
        lock {
            foreach Students item in studentTable {
                if(studentNumber == item.studentNumber){
                    return studentTable.get(studentNumber);
                }else{
                    return "student does not exist";
                }
            }
        }        
    }
    
    resource function post student(@http:Payload Students[] studentEntries) returns CreatedStudentEntries{
        lock{
        studentEntries.forEach(Students => studentTable.add(Students));
        return <CreatedStudentEntries>{body:studentEntries};
    }
    
   }

    resource function put student/[int studentNumber](@http:Payload Students[] updateEntry) returns CreatedStudentEntries|anydata{
        lock{
        foreach Students item in studentTable{
            if studentNumber == item.studentNumber {
                updateEntry.forEach(Students => studentTable.put(Students));
            }
        }
        return<CreatedStudentEntries>{body:updateEntry};                           
        }
    }

    resource function put updateCourse/[int studentNumber](@http:Payload map<string> courses) returns string{
        foreach Students i in studentTable{
            if studentNumber == i.studentNumber {
                i.courses = courses;
                return "update is successful";
            }
            else{
                return "no such field exists";
            }
        }
        return "update is successful";
    }
    
    resource function delete student/[int studentNumber]() returns string{
    foreach Students item in studentTable {
        if studentNumber == item.studentNumber{
            Students remove = studentTable.remove(studentNumber);
            io:print(remove);
            return "deleted successfully";
        }
        else{
            return "no such field exists";
        }
    }
        return "deleted successfully";
    }

   
}