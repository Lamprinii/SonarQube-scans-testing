import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _; // Import the MySQL driver

// Retrieve config variables
configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable int PORT = ?;
configurable string DATABASE = ?;

listener http:Listener endpoint = new (8080);

service / on endpoint {
    final mysql:Client dbClient;
    // Connect to the MySQL database
    function init() returns error? {
        self.dbClient = check new (host = HOST,
            user = USER,
            password = PASSWORD,
            port = PORT,
            database = DATABASE
        );
    }

    // Noncompliant
    // resource function get authenticate(string userName, string password) returns string{
    //     // Check if user name exists
    //     sql:ParameterizedQuery query = `SELECT userName
    //         FROM user_details
    //         WHERE userName = ${userName}`;

    //     // Run the query and retrieve the results
    //     string|sql:Error user = self.dbClient->queryRow(query);

    //     if (user is error) {
    //         return "User not found!"; // Sensitive
    //     }

    //     // check if passwords match for the given user
    //     query = `SELECT userPass
    //         FROM user_details
    //         WHERE userName = ${userName}
    //         AND userPass = ${password}`;

    //     string|sql:Error pass = self.dbClient->queryRow(query);
    //     if (pass is error) {
    //         return "Password incorrect!"; // Sensitive
    //     }

    //     // If both checks pass return success message
    //     return "User authenticated!";
    // }

    // Compliant
    resource function get authenticate(string userName, string password) returns string {
        // Check if user name exists
        sql:ParameterizedQuery query = `SELECT userName
            FROM user_details
            WHERE userName = ${userName}`;

        // Run the query and retrieve the results
        string|sql:Error user = self.dbClient->queryRow(query);

        if (user is error) {
            // Hide this exception reason to not disclose that the username doesn't exist
        }

        // check if passwords match for the given user
        query = `SELECT userPass
            FROM user_details
            WHERE userName = ${userName}
            AND userPass = ${password}`;

        string|sql:Error pass = self.dbClient->queryRow(query);
        if (user is error || pass is error) {
            // User should not be able to guess if the bad credentials message is related to the username or the password
            return "Bad credentials!";
        }

        // If both checks pass return success message
        return "User authenticated!";
    }
}
