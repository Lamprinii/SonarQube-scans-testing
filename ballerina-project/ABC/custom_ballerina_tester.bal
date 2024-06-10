// =====
// NOTES
// =====
// Bal scan should work exactly like the bal build command
// in that since bal build does not pick up this file when "bal build" is executed
// bal scan should not pick up this file when "bal scan" is executed
// in a project containing multiple single bal files bal build fails
// similarly "bal scan" should not attempt to scan single file projects
// bal build builds when a sinle bal file is passed as an argument
// similarly "bal scan" should scan when a single bal file is passed as an argument
import ballerina/io;

// Empty function
public function emptyCustomFunction() {
}

// Checkpanic function
public function checkPanicFunction() {
    string value = checkpanic tooManyParamsFunction("param1",
                                                    "param2",
                                                    "param3",
                                                    "param4",
                                                    "param5",
                                                    "param6",
                                                    "param7",
                                                    "param8");

    io:println(value);
}

// Greater than 7 parameters function
public function tooManyParamsFunction(string param1,
        string param2,
        string param3,
        string param4,
        string param5,
        string param6,
        string param7,
        string param8) returns string|error {
    return "someRandomString";
}
