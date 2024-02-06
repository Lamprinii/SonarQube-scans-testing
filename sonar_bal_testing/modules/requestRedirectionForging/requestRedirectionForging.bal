import ballerina/http;

listener http:Listener endpoint = new (8080);

// Noncompliant
service / on endpoint {
    resource function get doGet(http:Caller caller, string url) returns error? {
        http:Response response = new http:Response();

        // Noncompliant
        string[] redirectUrls = [url];
        check caller->redirect(response, http:REDIRECT_FOUND_302, redirectUrls);
    }
};

// // Compliant
// service / on endpoint {
//     resource function get doGet(http:Caller caller, string url) returns error? {
//         http:Response response = new http:Response();

//         // Compliant
//         if url.includesMatch(re `http://trusted1.example.com/.*`) {
//             string[] redirectUrls = [url];
//             check caller->redirect(response, http:REDIRECT_FOUND_302, redirectUrls);
//         }
//     }
// };

// // Compliant
// service / on endpoint {
//     resource function get doGet(http:Caller caller, string url) returns error? {
//         http:Response response = new http:Response();

//         // Compliant
//         string[] allowedHosts = [];
//         allowedHosts.push("http://trusted1.example.com");
//         allowedHosts.push("http://trusted2.example.com");
//         boolean hostIsSecure = allowedHosts.some(allowedHost =>
//             allowedHost.equalsIgnoreCaseAscii(url)
//         );

//         if hostIsSecure {
//             string[] redirectUrls = [url];
//             check caller->redirect(response, http:REDIRECT_FOUND_302, redirectUrls);
//         }
//     }
// };
