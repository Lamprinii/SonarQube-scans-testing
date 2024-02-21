import ballerina/crypto;
import ballerina/http;
// import ballerina/lang.array;
import ballerina/random;
// import ballerina/sql;
// import ballerinax/java.jdbc; // for JDBC operations, driver should be added to Ballerina.toml
// import ballerinax/mysql; // for MYSQL operations
// import ballerinax/mysql.driver as _; // for MYSQL operations
// import ballerinax/postgresql; // For PostgreSQL operations
// import ballerinax/postgresql.driver as _; // for PostgreSQL operations
import ballerinax/mongodb; // For MongoDB operations

listener http:Listener endpoint = new (8080);

// -------------------
// h2 Database
// -------------------
// configurable string USER = ?;
// configurable string PASSWORD = ?;
// configurable string DATABASE = ?;

// final jdbc:Client dbClient;

// service / on endpoint {

//     function init() returns error? {
//         // Connect to the MySQL database
//         dbClient = check new jdbc:Client(url = string `jdbc:h2:./h2/${DATABASE}`,
//             user = USER,
//             password = PASSWORD
//         );
//         // sql:ParameterizedQuery query = `CREATE TABLE users (user_name VARCHAR(50) NOT NULL, user_pass VARCHAR(250) NOT NULL)`;
//         // sql:ExecutionResult result = check dbClient->execute(query);
//     }

//     // Get all users in the database
//     resource function get getAllUsers() returns json[]|error? {
//         // Retrieve all users from the database
//         sql:ParameterizedQuery query = `SELECT * FROM users`;
//         stream<record {}, sql:Error?> resultStream = dbClient->query(query);

//         json[] results = [];
//         check from record {} user in resultStream
//             do {
//                 json userJson = {
//                 "user_name": user.get("USER_NAME").toString(),
//                 "user_pass": user.get("USER_PASS").toString()
//             };
//                 results.push(userJson);
//             };

//         return results;
//     }

//     // Noncompliant
//     resource function post createUser1(http:Request request) returns json|error? {
//         // Retrieve the JSON payload from the create request
//         json data = check request.getJsonPayload();
//         string userName = check data.userName;
//         string password = check data.password;

//         // Noncompliant
//         // save to DB
//         sql:ExecutionResult result = check dbClient->execute(`INSERT INTO users VALUES (${userName}, ${password})`);

//         // Return the inserted user
//         return result.toJson();
//     }

//     // Compliant
//     resource function post createUser(http:Request request) returns json|error? {
//         // Retrieve the JSON payload from the create request
//         json data = check request.getJsonPayload();
//         string userName = check data.userName;
//         string password = check data.password;

//         // Create a salt
//         byte[16] salt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//         foreach int i in 0 ... (salt.length() - 1) {
//             salt[i] = <byte>(check random:createIntInRange(0, 255));
//         }

//         // Compliant
//         // Hash the password
//         byte[] hashedPassword = crypto:hashSha512(password.toBytes(), salt);

//         // Add the salt to the hashed password
//         byte[] saltedHashPassword = [...salt, ...hashedPassword];

//         // convert it to a base 16 string (to save in a DB)
//         string saltedHashPasswordString = saltedHashPassword.toBase16();

//         // Save to DB
//         sql:ExecutionResult result = check dbClient->execute(`INSERT INTO users VALUES (${userName}, ${saltedHashPasswordString})`);

//         // Return the inserted user
//         return result.toJson();
//     }
// }

// --------------
// MySQL Database
// --------------
// configurable string USER = ?;
// configurable string PASSWORD = ?;
// configurable string HOST = ?;
// configurable int PORT = ?;
// configurable string DATABASE = ?;

// final mysql:Client dbClient;

// service / on endpoint {

//     function init() returns error? {
//         // Connect to the MySQL database
//         dbClient = check new (host = HOST,
//             user = USER,
//             password = PASSWORD,
//             port = PORT,
//             database = DATABASE
//         );
//     }

//     // Create user with hashed and salted password
//     resource function get getAllUsers() returns json[]|error? {
//         // Retrieve all users from the database
//         sql:ParameterizedQuery query = `SELECT * FROM users`;
//         stream<record {}, sql:Error?> resultStream = dbClient->query(query);

//         json[] results = [];
//         check from record {} user in resultStream
//             do {
//                 json userJson = {
//                 "user_name": user.get("user_name").toString(),
//                 "user_pass": user.get("user_pass").toString()
//             };
//                 results.push(userJson);
//             };

//         return results;
//     }

//     // Noncompliant
//     resource function post createUser1(http:Request request) returns json|error? {
//         // Retrieve the JSON payload from the create request
//         json data = check request.getJsonPayload();
//         string userName = check data.userName;
//         string password = check data.password;

//         // Noncompliant
//         // save to DB
//         sql:ExecutionResult result = check dbClient->execute(`INSERT INTO users VALUES (${userName}, ${password})`);

//         // Return the inserted user
//         return result.toJson();
//     }

//     // Compliant
//     resource function post createUser(http:Request request) returns json|error? {
//         // Retrieve the JSON payload from the create request
//         json data = check request.getJsonPayload();
//         string userName = check data.userName;
//         string password = check data.password;

//         // Create a salt
//         byte[16] salt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//         foreach int i in 0 ... (salt.length() - 1) {
//             salt[i] = <byte>(check random:createIntInRange(0, 255));
//         }

//         // Compliant
//         // Hash the password
//         byte[] hashedPassword = crypto:hashSha512(password.toBytes(), salt);

//         // Add the salt to the hashed password
//         byte[] saltedHashPassword = [...salt, ...hashedPassword];

//         // convert it to a base 16 string (to save in a DB)
//         string saltedHashPasswordString = saltedHashPassword.toBase16();

//         // Save to DB
//         sql:ExecutionResult result = check dbClient->execute(`INSERT INTO users VALUES (${userName}, ${saltedHashPasswordString})`);

//         // Return the inserted user
//         return result.toJson();
//     }

//     resource function put updateCredentials1(http:Request request) returns json|error? {
//         // Retrieve the JSON payload from the update request
//         json data = check request.getJsonPayload();
//         string userName = check data.userName;
//         string oldPassword = check data.oldPassword;
//         string newPassword = check data.newPassword;

//         // Retrieve the user's old password from the database
//         sql:ParameterizedQuery query = `SELECT * FROM users where user_name = ${userName}`;
//         record {} result = check dbClient->queryRow(query);
//         string storedOldPassword = result.get("user_pass").toString();

//         // Noncompliant
//         if (oldPassword.equalsIgnoreCaseAscii(storedOldPassword)) {
//             // Update DB
//             sql:ExecutionResult execResult = check dbClient->execute(`UPDATE users SET user_pass=${newPassword} WHERE user_name=${userName}`);

//             return execResult.toJson();
//         }

//         return "Old password does not match";
//     }

// resource function put updateCredentials(http:Request request) returns json|error? {
//     // Retrieve the JSON payload from the update request
//     json data = check request.getJsonPayload();
//     string userName = check data.userName;
//     string oldPassword = check data.oldPassword;
//     string newPassword = check data.newPassword;

//     // Retrieve the user's old password from the database
//     sql:ParameterizedQuery query = `SELECT * FROM users where user_name = ${userName}`;
//     record {} result = check dbClient->queryRow(query);

//     string storedOldPassword = result.get("user_pass").toString();

//     // Compliant
//     byte[] oldSaltedHashPassword = check array:fromBase16(storedOldPassword);

//     byte[16] saltObtained = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//     foreach int i in 0 ... (saltObtained.length() - 1) {
//         saltObtained[i] = oldSaltedHashPassword[i]; // Obtaining the salt
//     }

//     byte[] userGivenOldHashPassword = crypto:hashSha512(oldPassword.toBytes(), saltObtained);
//     byte[] userGivenOldSaltedHashPassword = [...saltObtained, ...userGivenOldHashPassword];

//     // If the old password does not match the one in the database, return an error
//     if (oldSaltedHashPassword != userGivenOldSaltedHashPassword) {
//         return "Old password does not match";
//     }

//     // Update the users new password (salted and hashed)
//     byte[16] salt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//     foreach int i in 0 ... (salt.length() - 1) {
//         salt[i] = <byte>(check random:createIntInRange(0, 255));
//     }

//     // Hash the password
//     byte[] hashedPassword = crypto:hashSha512(newPassword.toBytes(), salt);

//     // Add the salt to the hashed password
//     byte[] saltedHashPassword = [...salt, ...hashedPassword];

//     // convert it to a base 16 string (to save in a DB)
//     string saltedHashPasswordString = saltedHashPassword.toBase16();

//     // Save to DB
//     sql:ExecutionResult execResult = check dbClient->execute(`UPDATE users SET user_pass=${saltedHashPasswordString} WHERE user_name=${userName}`);

//     return execResult.toJson();
// }
// }

// -------------------
// Postgresql Database
// -------------------
// configurable string HOST = ?;
// configurable string USER = ?;
// configurable string PASSWORD = ?;
// configurable string DATABASE = ?;
// configurable int PORT = ?;

// final postgresql:Client dbClient;

// service / on endpoint {

//     function init() returns error? {
//         // Connect to the MySQL database
//         dbClient = check new (host = HOST,
//             username = USER,
//             password = PASSWORD,
//             port = PORT,
//             database = DATABASE
//         );
//     }

//     // Create user with hashed and salted password
//     resource function get getAllUsers() returns json[]|error? {
//         // Retrieve all users from the database
//         sql:ParameterizedQuery query = `SELECT * FROM users`;
//         stream<record {}, sql:Error?> resultStream = dbClient->query(query);

//         json[] results = [];
//         check from record {} user in resultStream
//             do {
//                 json userJson = {
//                 "user_name": user.get("user_name").toString(),
//                 "user_pass": user.get("user_pass").toString()
//             };
//                 results.push(userJson);
//             };

//         return results;
//     }

//     // Noncompliant
//     resource function post createUser1(http:Request request) returns json|error? {
//         // Retrieve the JSON payload from the create request
//         json data = check request.getJsonPayload();
//         string userName = check data.userName;
//         string password = check data.password;

//         // Noncompliant
//         // save to DB
//         sql:ExecutionResult result = check dbClient->execute(`INSERT INTO users VALUES (${userName}, ${password})`);

//         // Return the inserted user
//         return result.toJson();
//     }

//     // Compliant
//     resource function post createUser(http:Request request) returns json|error? {
//         // Retrieve the JSON payload from the create request
//         json data = check request.getJsonPayload();
//         string userName = check data.userName;
//         string password = check data.password;

//         // Create a salt
//         byte[16] salt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//         foreach int i in 0 ... (salt.length() - 1) {
//             salt[i] = <byte>(check random:createIntInRange(0, 255));
//         }

//         // Compliant
//         // Hash the password
//         byte[] hashedPassword = crypto:hashSha512(password.toBytes(), salt);

//         // Add the salt to the hashed password
//         byte[] saltedHashPassword = [...salt, ...hashedPassword];

//         // convert it to a base 16 string (to save in a DB)
//         string saltedHashPasswordString = saltedHashPassword.toBase16();

//         // Save to DB
//         sql:ExecutionResult result = check dbClient->execute(`INSERT INTO users VALUES (${userName}, ${saltedHashPasswordString})`);

//         // Return the inserted user
//         return result.toJson();
//     }
// }

// ----------------
// MongoDB Database
// ----------------
configurable string CONNECTION_URL = ?;
configurable string DATABASE = ?;

final mongodb:Client dbClient;

service / on endpoint {

    function init() returns error? {
        mongodb:ConnectionConfig config = {
            connection: {
                url: CONNECTION_URL
            },
            databaseName: DATABASE
        };
        // Connect to the MySQL database
        dbClient = check new (config);
    }

    // Create user with hashed and salted password
    resource function get getAllUsers() returns json[]|error? {
        // Retrieve all users from the database
        stream<record {}, error?> resultStream = check dbClient->find("users", (), ());
        json[] results = [];
        check from record {} user in resultStream
            do {
                json userJson = {
                "user_name": user.get("user_name").toString(),
                "user_pass": user.get("user_pass").toString()
            };
                results.push(userJson);
            };

        return results;
    }

    // Noncompliant
    resource function post createUser1(http:Request request) returns json|error? {
        // Retrieve the JSON payload from the create request
        json data = check request.getJsonPayload();
        string userName = check data.userName;
        string password = check data.password;

        // Noncompliant
        // save to DB
        map<json> doc = {"user_name": userName, "user_pass": password};
        check dbClient->insert(doc, "users");

        // Return the inserted user
        return doc.toJson();
    }

    // Compliant
    resource function post createUser(http:Request request) returns json|error? {
        // Retrieve the JSON payload from the create request
        json data = check request.getJsonPayload();
        string userName = check data.userName;
        string password = check data.password;

        // Create a salt
        byte[16] salt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        foreach int i in 0 ... (salt.length() - 1) {
            salt[i] = <byte>(check random:createIntInRange(0, 255));
        }

        // Compliant
        // Hash the password
        byte[] hashedPassword = crypto:hashSha512(password.toBytes(), salt);

        // Add the salt to the hashed password
        byte[] saltedHashPassword = [...salt, ...hashedPassword];

        // convert it to a base 16 string (to save in a DB)
        string saltedHashPasswordString = saltedHashPassword.toBase16();

        // Save to DB
        map<json> doc = {"user_name": userName, "user_pass": saltedHashPasswordString};
        check dbClient->insert(doc, "users");

        // Return the inserted user
        return doc.toJson();
    }
}

// ==========================
// Salting and Veryfying Code
// ==========================
// resource function post createUser(http:Request request) returns json[]|error? {
//     // Retrieve the JSON payload from the create request
//     json data = check request.getJsonPayload();
//     string userName = check data.userName;
//     string password = check data.password;

//     // Create a salt
//     byte[16] salt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//     foreach int i in 0 ... (salt.length() - 1) {
//         salt[i] = <byte>(check random:createIntInRange(0, 255));
//     }

//     // Hash the password
//     byte[] hashedPassword = crypto:hashSha512(password.toBytes(), salt);

//     // Add the salt to the hashed password
//     byte[] saltedHashPassword = [...salt, ...hashedPassword];

//     // convert it to a base 16 string (to save in a DB)
//     string hashedPasswordString = saltedHashPassword.toBase16();

//     // Save to DB

//     // Retrieve from DB for verification
//     // Retrieve the salted part from the hashed password string
//     byte[] oldSaltedHashPassword = check array:fromBase16(hashedPasswordString);

//     byte[16] saltObtained = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//     foreach int i in 0 ... (saltObtained.length() - 1) {
//         saltObtained[i] = oldSaltedHashPassword[i]; // We remove the salt and therby only maintain the hash for comparison
//     }
//     byte[] newPasswordHash = crypto:hashSha512(password.toBytes(), saltObtained);
//     byte[] newSaltedHashPassword = [...saltObtained, ...newPasswordHash];

//     // Success message
//     return [{
//         "user_name": userName,
//         "user_pass": hashedPassword.toBase16(),
//         "salt": salt.toBase16(),
//         "salted_user_pass": saltedHashPassword.toBase16(),
//         "old_salted_user_pass": oldSaltedHashPassword.toBase16(),
//         "salt_obtained": saltObtained.toBase16(),
//         "new_salted_user_pass": newSaltedHashPassword.toBase16()
//     }];
// }
