import ballerina/http;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    // Noncompliant
    // resource function get example() returns http:Response|error? {
    //     http:Response response = new http:Response();

    //     // Sensitive: this sensitive cookie is created with the httponly flag not defined (by default set to false) and so it can be stolen easily in case of XSS vulnerability
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
            httpOnly = true
        );
        response.addCookie(cookie);

        return response;
    }
}
