import ballerina/http;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    // Noncompliant
    // resource function get example() returns http:Response|error? {
    //     http:Response response = new http:Response();

    //     // Sensitive: a security-ensitive cookie is created with the secure flag set to false
    //     http:Cookie cookie = new ("COOKIENAME", "sensitivedata");
    //     response.addCookie(cookie);

    //     return response;
    // }

    // Compliant
    resource function get example() returns http:Response|error? {
        http:Response response = new http:Response();

        // Compliant: this sensitive cookie is protected against theft (HttpOnly=true)
        http:Cookie cookie = new (
            "COOKIENAME",
            "sensitivedata",
            secure = true
        );
        response.addCookie(cookie);

        return response;
    }
}
