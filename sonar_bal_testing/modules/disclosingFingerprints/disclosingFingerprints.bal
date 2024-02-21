import ballerina/http;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    // Noncompliant
    // resource function get example() returns http:Response|error? {
    //     http:Response response = new;
    //     response.setHeader("x-powered-by", "myproduct"); // Sensitive
    //     response.setPayload("example");
    //     return response;
    // }

    // Compliant
    resource function get example() returns http:Response|error? {
        http:Response response = new;
        // response.setHeader("x-powered-by", "myproduct"); // Compliant
        response.setPayload("example");
        return response;
    }
}
