import ballerina/io;

public function getResult(int num1, int num2) returns json|error {
    return {n1: num1, n2: num2};
}

public function nonCompliantSolution() {
    json returnedValue = checkpanic getResult(1, 2);
    io:println("Returned value: " + returnedValue.toString());
}

public function compliantSolution1() {
    json|error returnedValue = getResult(1, 2);

    if returnedValue is error {
        io:println("Error occurred: " + returnedValue.toString());
    } else {
        io:println("Returned value: " + returnedValue.toString());
    }
}

public function compliantSolution2() returns error? {
    json result = check getResult(1, 2);
    io:println("Returned value: " + result.toString());
}

public function checkRule() {
    nonCompliantSolution();
    compliantSolution1();
    error? result = compliantSolution2();
}
