import ballerina/http;
import ballerina/io;
import ballerinax/mongodb;

// Retrieve config variables
configurable string CONNECTION_URL = ?;

// Define the connection to the database
mongodb:ConnectionConfig mongoConfig = {
    connection: {
        url: CONNECTION_URL
    }
};

// Set up the client
mongodb:Client mongoClient = check new (mongoConfig);

// Define the record type
type User record {
    string username;
    string address;
    int age;
    string email;
    string phone;
};

listener http:Listener endpoint = new (8080);

// Define the service endpoint
service / on endpoint {
    resource function get userDetails(string userFilter) returns json|error? {
        // Noncompliant
        map<json> filter = {"$where": "this.username == '" + userFilter + "'"};
        stream<User, error?> results = check mongoClient->find("ExampleCollection", "ExampleDatabase", filter);

        // ...
        User[] users = [];

        check results.forEach(function(User user) {
            io:println(user);
            users.push(user);
        });

        return users.toJson();
    }
}

// type ExampleRecord record {
//     string exampleField1;
//     string exampleField2;
// };

// Noncompliant
// service / on endpoint {
//     resource function get doGet(string input) returns json|error? {
//         // Noncompliant
//         map<json> filter = {"$where": "this.field == '" + input + "'"};
//         stream<ExampleRecord, error?> results = check mongoClient->find("ExampleCollection",
//             "ExampleDatabase",
//             filter);

//         // ...
//     }
// }

// Compliant
// service / on endpoint {
//     resource function get doGet(string input) returns json|error? {
//         // Compliant
//         map<json> filter = {"field": input};
//         stream<ExampleRecord, error?> results = check mongoClient->find("ExampleCollection",
//             "ExampleDatabase",
//             filter);

//         // ...
//     }
// }
