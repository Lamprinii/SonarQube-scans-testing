import ballerina/io;
import ballerina/websocket; // module is not working with version 8.5 patch

// // ====
// // NOTE
// // ====
// // - Before calling checkRule function, run webSocketServiceProject file

public function checkRule() {
    error? e1 = nonCompliantSolution();
    if (e1 is error) {
        io:println("Error occurred: ", e1.message());
    }

    // error? e2 = compliantSolution1();
    // if (e2 is error) {
    //     io:println("Error occurred: ", e2.message());
    // }

    // error? e3 = compliantSolution2();
    // if (e3 is error) {
    //     io:println("Error occurred: ", e3.message());
    // }
}

public function nonCompliantSolution() returns error? {
    string ip = "ws://localhost:8080/chat"; // Sensitive
    websocket:Client chatClient = check new (ip);
    // ...

    check chatClient->writeMessage("Hello Jhon!");

    string message = check chatClient->readMessage();
    io:println(message);
}

// // Compliant solution 1
// configurable string WEBSOCKET_IP = ?;

// public function compliantSolution1() returns error? {
//     websocket:Client chatClient = check new (WEBSOCKET_IP);
//     // ...

//     check chatClient->writeMessage("Hello Scarlet!");

//     string message = check chatClient->readMessage();
//     io:println(message);
// }

// // Compliant solution 2 (
// //```cmd
// // set WEB_SOCKET_IP=ip_address
// //````
// //)
// public function compliantSolution2() returns error? {
//     string ip = os:getEnv("WEBSOCKET_IP");
//     websocket:Client chatClient = check new (ip);
//     // ...

//     check chatClient->writeMessage("Hello Bob!");

//     string message = check chatClient->readMessage();
//     io:println(message);
// }
