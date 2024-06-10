import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

listener http:Listener endpoint = new (8080);

configurable string user = ?;
configurable string password = ?;
configurable string host = ?;
configurable int port = ?;
configurable string database = ?;

final mysql:Client dbClient;

service / on endpoint {
    function init() returns error? {
        dbClient = check new mysql:Client(
            host = host,
            port = port,
            user = user,
            password = password,
            database = database
        );
    }

    // Noncompliant
    // resource function get employees() returns json[]|error? {
    //     // Do the stored procedure call
    //     sql:ProcedureCallResult procedureCallResult = check dbClient->call(`call getEmployeeDetails()`);

    //     // Retrieve procedure call result
    //     stream<record {}, sql:Error?>? resultStream = procedureCallResult.queryResult;

    //     // Transform the result
    //     json[] results = [];
    //     if resultStream is stream<record {}, sql:Error?> {
    //         check from record {} employee in resultStream
    //             do {
    //                 json employeeJson = {
    //                     "first_name": employee.get("first_name").toString(),
    //                     "last_name": employee.get("last_name").toString(),
    //                     "email": employee.get("email").toString()
    //                 };
    //                 results.push(employeeJson);
    //             };
    //     }

    //     return results;
    // }

    // Compliant
    resource function get employees() returns json[]|error? {
        // Do the stored procedure call
        sql:ProcedureCallResult procedureCallResult = check dbClient->call(`call getEmployeeDetails()`);

        // Retrieve procedure call result
        stream<record {}, sql:Error?>? resultStream = procedureCallResult.queryResult;

        // Transform the result
        json[] results = [];
        if resultStream is stream<record {}, sql:Error?> {
            check from record {} employee in resultStream
                do {
                    json employeeJson = {
                        "first_name": employee.get("first_name").toString(),
                        "last_name": employee.get("last_name").toString(),
                        "email": employee.get("email").toString()
                    };
                    results.push(employeeJson);
                };
        }

        // Close the procedure call
        check procedureCallResult.close();

        return results;
    }
}
