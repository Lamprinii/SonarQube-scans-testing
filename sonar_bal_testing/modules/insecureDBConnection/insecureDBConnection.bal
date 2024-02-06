import ballerina/io;
import ballerinax/mysql;
import ballerinax/mysql.driver as _; // Import the MySQL driver

// Retrieve config variables
configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable int PORT = ?;
configurable string DATABASE = ?;

public function connectToDatabase() {
    mysql:Client|error dbClient = new (host = HOST,
        user = USER,
        password = PASSWORD, // Noncompliant
        port = PORT,
        database = DATABASE
    );

    // ...
    if !(dbClient is error) {
        io:println("Connection successful!");
    } else {
        io:println("Connection Error!");
        io:println(dbClient);
    }
}

// public function connectToDatabase() {
//     mysql:Client|error dbClient = new (host = HOST,
//         user = USER,
//         password = PASSWORD, // Compliant
//         port = PORT,
//         database = DATABASE
//     );

//     // ...
//     if !(dbClient is error) {
//         io:println(dbClient);
//     }
// }
