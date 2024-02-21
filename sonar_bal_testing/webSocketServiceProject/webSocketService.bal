import ballerina/io;
import ballerina/websocket;

listener websocket:Listener socketEndpoint = new (8080);

service / on socketEndpoint {
    function init() returns error? {
        io:println("Chat service initializing");
    }

    resource function get chat() returns websocket:Service {
        // Return the service when client invokes it
        return new ChatService();
    }
}

service class ChatService {
    *websocket:Service;

    remote function onMessage(websocket:Caller caller, string chatMessage) returns error? {
        io:println(chatMessage);
        check caller->writeMessage("Hello, How are you?");
    }
}
