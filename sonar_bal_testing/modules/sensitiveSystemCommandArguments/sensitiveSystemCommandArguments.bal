import ballerina/http;
import ballerina/io;
import ballerina/os;

listener http:Listener endpoint = new (8080);

// Noncompliant
service / on endpoint {
    resource function get doGet(http:Request request) returns json|error? {
        string input = request.getQueryParamValue("input").toString();
        string[] cmd = ["/c", "dir", "/b", "/s", "|", "find", input];
        os:Process result = check os:exec({value: "cmd.exe", arguments: cmd}); // Sensitive
        byte[] byteArray = check result.output();
        string|error filePaths = string:fromBytes(byteArray);

        if (filePaths is error) {
            return filePaths;
        }

        io:println(filePaths);
        return {files: filePaths};
    }
}

// Compliant
// service / on endpoint {
//     resource function get doGet(http:Request request) returns json|error? {
//         string input = request.getQueryParamValue("input").toString();
//         string[] cmd = ["/c", "dir", "/b", "/s", "|", "find", "\"" + input + "\""];
//         string[] allowed = ["main", "main.bal", "bal"];
//         if (allowed.some(keyword => keyword.equalsIgnoreCaseAscii(input))) {
//             os:Process result = check os:exec({value: "cmd.exe", arguments: cmd});
//             byte[] byteArray = check result.output(); // Sensitive
//             string|error filePaths = string:fromBytes(byteArray);

//             if (filePaths is error) {
//                 return filePaths;
//             }

//             io:println(filePaths);
//             return {files: filePaths};
//         }
//     }
// }
