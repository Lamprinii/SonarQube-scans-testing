import ballerina/io;

public function chekRule() {
    // curlyBraceInlineBlockCheck();
    // duplicateConstituentsInUnionsCheck();
    conditionalStatementClosureCheck();
}

function curlyBraceInlineBlockCheck() {
    boolean valid = true;
    // Noncompliant
    if valid
    {
        doSomething();
    }

    // Compliant
    if valid {
        doSomething();
    }

}

function doSomething() {
    io:println("Something");
}

function duplicateConstituentsInUnionsCheck() {
    // Compliant
    string|int value = returnSomething(0);
    io:println(value);

    // Noncompliant
    string|string|int value2 = returnSomething(1);
    io:println(value2);
}

function returnSomething(int value) returns string|int {
    match value {
        0 => {
            return 1000;
        }

        1 => {
            return "one";
        }

        _ => {
            return "Default";
        }
    }
}

function conditionalStatementClosureCheck() {
    boolean valid = false;
    boolean active = true;

    // Noncompliant
    if (valid) {
        io:println("True");
    } else if (active) {
        io:println("False");
    }

    // Compliant
    if valid {
        io:println("True");
    } else if active {
        io:println("False");
    }
}
