import ballerina/file;
import ballerina/io;
import ballerina/os;

// import ballerina/os;

public function checkRule() {
    // error? e = publicWritableDirectoriesChecker();
    // if (e is error) {
    //     io:println("Error occurred while creating file");
    //     io:println(e.message());
    // }

    error? e2 = compliantSolution();
    if (e2 is error) {
        io:println("Error occurred while creating file");
        io:println(e2.message());
    }
}

public function compliantSolution() returns error? {
    check file:create("./myDirectory/myfile.txt"); // Compliant
    string pathOfFile = check file:getAbsolutePath("./myDirectory/myfile.txt"); // Compliant
    io:println(pathOfFile);
}

public function publicWritableDirectoriesChecker() returns error? {
    string tempFolderPath = os:getEnv("TMP"); // Sensitive
    check file:create(tempFolderPath + "/" + "myfile.txt"); // Sensitive
    string pathOfFile = check file:getAbsolutePath(tempFolderPath + "/" + "myfile.txt"); // Sensitiveive
    io:println(pathOfFile);

    string pathOfFile2 = check file:createTemp("suffix", "prefix"); // Sensitive, will be in the default temporary-file directory.
    io:println(pathOfFile2);

    string pathOfDirectory = check file:createTempDir((), "prefix"); // Sensitive, will be in the default temporary-file directory.
    io:println(pathOfDirectory);
}
