import ballerina/io;
import ballerinax/mysql;
import ballerinax/mysql.driver as _; // Import the MySQL driver

// Retrieve config variables
configurable string user = ?;
configurable string password = ?;
configurable string host = ?;
configurable int port = ?;
configurable string database = ?;

public function connectToDatabase() {
    mysql:Client|error dbClient = new (host = host,
        user = user,
        password = password, // Noncompliant
        port = port,
        database = database
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
