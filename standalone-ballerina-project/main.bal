import ballerina/io;

// For having custom scans included (To be used with bal scan tool)
// import tharana_wanigaratne/compiler_plugin_customRules as _;
// For having custom scans included (To be used with bal bridge tool)
import tharana_wanigaratne/custom_compiler_plugin as _;

// Empty function
public function emptyCustomFunction() {
}

// Checkpanic function
public function checkPanicFunction() {
    string checkpanicVariable = checkpanic tooManyParamsFunction("param1",
                                                    "param2",
                                                    "param3",
                                                    "param4",
                                                    "param5",
                                                    "param6",
                                                    "param7",
                                                    "param8");

    checkpanicVariable = "checkpanic";

    io:println(checkpanicVariable);
}

// Checkpanic function
public function checkPanicFunction2() {
    string checkpanicVariable = checkpanic tooManyParamsFunction("param1",
                                                    "param2",
                                                    "param3",
                                                    "param4",
                                                    "param5",
                                                    "param6",
                                                    "param7",
                                                    "param8");

    checkpanicVariable = "checkpanic";

    io:println(checkpanicVariable);
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
