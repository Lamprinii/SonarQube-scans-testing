import ballerina/http;
import ballerina/io;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    // Sensitive: by default all HTTP methods are allowed
    resource function default deleteRequest(http:Request clientRequest, string username) returns string {
        // state of the application will be changed here
        io:println("Client request method is: " + clientRequest.method);
        return "Hello, " + username;
    }
}

// Define the service endpoint (Secure and Compliant)
// service / on endpoint {
//     // Compliant
//     resource function delete deleteRequest(http:Request clientRequest, string username) returns string {
//         // state of the application will be changed here
//         io:println("Client request method is: " + clientRequest.method);
//         return "Hello, " + username;
//     }
// }
