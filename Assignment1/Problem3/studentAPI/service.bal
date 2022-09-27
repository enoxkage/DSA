import ballerina/http;

public type Student record {

int studentNumber?;
string studentName?;
string studentSurname?;
string studentEmail?;
Course studentCourse?;

};

Student[] allstu=[];

public type Course record {

readonly string code;
string courseName;
string weights;
int marks;

};

public table <Course> key(code) courseT= table [
{code: "dsa126s", courseName: "Distributed Systems", weights: "Assignment 1 = 25% Assignment 2 = 25%", marks: 50},
{code: "wad234s", courseName: "Web Application and Development", weights: "Assignment 1 = 25% Assignment 2 = 25%",marks: 45 },
{code: "efc178s", courseName: "Ethics for Computing", weights: "Assignment 1 = 25% Assignment 2 = 25%", marks: 78 }
];

public type createdStudent record {|

*http:Created;
createdStudent body;

|};



service /student on new http:Listener(9090) {

resource function get students() returns Student[]|http:Response {
    return allstu;
    
    }
    resource function post student(@http:Payload Student payload) returns createdStudent|http:Created {
    payload.studentNumber = allstu.length();
    allstu.push(payload);
    return <http:Created>{};
   
    }
    resource function get student/[int studentNumber]() returns Student|http:NotFound {
      Student? student = allstu[studentNumber];
        if student is () {
            return http:NOT_FOUND;
        } else {
            return student;
        }
    }
    resource function put student/[string username](@http:Payload Student payload) returns Student|http:Response {
      http:Response Updte =new;
    return Updte;
   
    }

    resource function put course/[string  username](@http:Payload Student payload) returns Course|http:Response {
    http:Response coursUpdte =new;
    return coursUpdte;
   
    }

    resource function delete student/[int studentNumber]() returns http:NoContent|http:Response {
     http:Response delet =new;
    return delet;
    }
}