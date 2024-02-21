import ballerina/io;
import ballerina/os;

public function checkRule() {
    // error? e1 = nonCompliantSolution();
    // if (e1 is error) {
    //     io:println("Error occurred: " + e1.message());
    // }

    error? e2 = compliantSolution();
    if (e2 is error) {
        io:println("Error occurred", e2.message());
    }
}

function nonCompliantSolution() returns error? {
    os:Process process = check os:exec({
        value: "bal",  // Sensitive
        arguments: ["help"]
        });
    byte[] processOutput = check process.output(io:stdout);
    io:println(string:fromBytes(processOutput));
}

function compliantSolution() returns error? {
    os:Process process = check os:exec({
        value: "C:/Program Files/Ballerina/bin/bal.bat",  // Compliant
        arguments: ["help"]
        });
    byte[] processOutput = check process.output(io:stdout);
    io:println(string:fromBytes(processOutput));
}
