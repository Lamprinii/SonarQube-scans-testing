import ballerina/http;
import ballerina/regex;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    // Noncompliant
    // resource function get index(string content) returns http:Response|error? {
    //     string htmlContent = string `
    //         <html>
    //             <body>
    //                 ${content} 
    //             </body>
    //         </html>
    //     `; // JS Injection (XSS attack)

    //     http:Response response = new;
    //     check response.setContentType("text/html");
    //     response.setPayload(htmlContent);
    //     return response;
    // }

    // Compliant
    resource function get index(string content) returns http:Response|error? {
        // Enabling auto escaping
        // Compliant
        string escapedContent = regex:replaceAll(content, "&", "&amp;");
        escapedContent = regex:replaceAll(escapedContent, "<", "&lt;");
        escapedContent = regex:replaceAll(escapedContent, ">", "&gt;");
        escapedContent = regex:replaceAll(escapedContent, "\"", "&quot;");
        escapedContent = regex:replaceAll(escapedContent, "'", "&apos;");

        string htmlContent = string `
            <html>
                <body>
                    ${escapedContent} 
                </body>
            </html>
        `;

        http:Response response = new;
        check response.setContentType("text/html");
        response.setPayload(htmlContent);
        return response;
    }
};
