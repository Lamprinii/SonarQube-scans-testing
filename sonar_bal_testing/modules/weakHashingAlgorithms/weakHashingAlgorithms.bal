import ballerina/crypto;
import ballerina/io;

public function checkRule() {
    string inputString = "s3cr37";
    byte[] key = inputString.toBytes();

    string dataString = "Hello Ballerina!";
    byte[] hash = dataString.toBytes();

    // Noncompliant
    byte[] hashedStringSha1 = crypto:hashSha1(key, hash); // Sensitive

    // compliantSolution1
    byte[] hashedStringSha512 = crypto:hashSha512(hash, key);

    // ...

    io:println("Hashed String: " + hashedStringSha1.toString());
    io:println("Hashed String: " + hashedStringSha512.toString());
}
