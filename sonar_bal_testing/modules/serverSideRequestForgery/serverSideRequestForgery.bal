import ballerina/http;
import ballerina/io;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    resource function get doGet(http:Caller caller, string urlName) returns error? {
        http:Client testClient = check new (urlName);

        // Noncompliant
        http:Response response = check testClient->get("/");

        // ...

        check caller->respond(response);
        io:println(response);
    }
};

// Define the service endpoint (Secure and Compliant)
// service / on endpoint {
//     resource function get doGet(http:Caller caller, string urlName) returns error? {
//         http:Client testClient = check new (urlName);

//         // Compliant
//         string[] allowedHosts = [];
//         allowedHosts.push("http://trusted1.example.com");
//         allowedHosts.push("http://trusted2.example.com");

//         boolean hostIsSecure = false;
//         foreach string host in allowedHosts {
//             if (host.equalsIgnoreCaseAscii(urlName)) {
//                 hostIsSecure = true;
//                 break;
//             }
//         }

//         if hostIsSecure {
//             http:Response response = check testClient->get("/");

//             // ...

//             io:println(response.getTextPayload());
//             check caller->respond(response);
//         } else {
//             io:println("Unauthorized request!");
//             check caller->respond("Unauthorized request!");
//         }
//     }
// };
