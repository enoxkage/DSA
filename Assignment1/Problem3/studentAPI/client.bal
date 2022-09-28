import ballerina/io;
import ballerina/http;

http:Client StudentClient = check new http:Client("http://localhost:9090/student");

function getStudents() returns error|any{
  json res = check StudentClient -> get("/all");
  io:println(res);
}

function deleteStudents() returns error|any{
  string res = check StudentClient ->delete("/remove/1");
    io:print(res);
}

function getStudent() returns error|any{
  json res = check StudentClient->get("/Student/1");
  io:println(res);
}

function postStudents() returns error|any{
  json res = check StudentClient -> post("/newStudents",[{studentNumber:1,name:"Grant",email:"kid@yahoo",courses:{"course code":"DSA621s", "weight":"36%","marks":"52%"}}]);
  io:print(res.toJson());

}

function updateStudents() returns error|any{
  string resUpd = check StudentClient -> put("/update/1",[{studentNumber:1,name:"Grant",email:"kid@gmail.com", courses:{"course code":"DTA621s","assessments":"test1", "weight":"36%","marks":"67%"}}]);
  io:println(resUpd.toBalString());
}

function updateCourse() returns error|any{
  string res = check StudentClient -> put("/updateCourseDetails/1",{"course code":"DSA621s", "weight":"36%","marks":"47%"});
  io:println(res);
}




public function main() returns error?{
  io:print(getStudents());
  io:print(updateStudents());
  //io:print(postStudents());
    //io:print(delete());
   //io:print(resp);
  //io:println(getOneStudent());
  //io:print(updateCourseDetails());
  //json resp = check StudentRecordClient ->get("/singleStudent/1");
}