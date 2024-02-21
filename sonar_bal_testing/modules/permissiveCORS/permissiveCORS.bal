import ballerina/http;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    // // Noncompliant
    // @http:ResourceConfig {
    //     cors: {
    //         allowOrigins: ["*"] // Sensitive
    //     }
    // }

    // Compliant
    @http:ResourceConfig {
        cors: {
            allowOrigins: ["trustedwebsite.com"] // Compliant
        }
    }
    resource function get example() returns http:Response|error? {
        http:Response response = new;
        check response.setContentType("text/plain");
        response.setPayload("example");
        return response;
    }
}
