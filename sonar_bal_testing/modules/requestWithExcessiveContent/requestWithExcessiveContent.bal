// import ballerina/graphql;
import ballerina/http;
import ballerina/io;
import ballerina/mime;

// =====================
// GraphQL service based
// =====================
// listener graphql:Listener endpoint = new (8080);

// // For visualizing graphql services in a web browser
// @graphql:ServiceConfig {
//     graphiql: {
//         enabled: true,
//         // Path is optional, if not provided, it will be dafulted to `/graphiql`.
//         path: "/testing"
//     }
// }

// service / on endpoint {
//     // For a graphql endpoint there should be at least 1 resource function
//     resource function get details() returns string {
//         return "Endpoint engaged!";
//     }

//     // Noncompliant
//     // remote function fileUpload(graphql:Upload file) returns string|error {
//     //     // Retrieve upload file information to upload
//     //     string fileName = file.fileName;
//     //     string path = string `./uploads/${fileName}`;

//     //     // Access the byte stream of the file sent by the client
//     //     stream<byte[], io:Error?> fileContent = file.byteStream;

//     //     // Write the file contents to the server file
//     //     check io:fileWriteBlocksFromStream(path, fileContent); // Sensitive

//     //     // Return success message if upload was successful
//     //     return string `File ${fileName} was uploaded successfully!`;
//     // }

//     // Compliant
//     remote function fileUpload(graphql:Upload file) returns string|error {
//         // Retrieve upload file information to upload
//         string fileName = file.fileName;
//         string path = string `./uploads/${fileName}`;

//         // Access the byte stream of the file sent by the client
//         stream<byte[], io:Error?> fileContent = file.byteStream;

//         // Iterate through byte stream and calculate the file size
//         int maxUploadSize = 1024 * 1024 * 8; // 8MB
//         int[] chunkSizes = check from byte[] byteChunk in fileContent
//             select byteChunk.length();
//         int fileSize = chunkSizes.reduce(isolated function(int totalSize, int chunkSize) returns int => totalSize + chunkSize, 0);

//         if (fileSize > maxUploadSize) {
//             return "File size exceeds the maximum upload size!";
//         }

//         // Write the file contents to the server file
//         check io:fileWriteBlocksFromStream(path, fileContent);

//         // Return success message if upload was successful
//         return "File " + fileName + " was uploaded successfully!";
//     }
// }

// ==================
// http service based
// ==================
listener http:Listener endpoint = new (8080);

service / on endpoint {
    // Noncompliant
    // resource function post fileUpload(http:Request request) returns string|error {
    //     mime:Entity[] bodyParts = check request.getBodyParts();

    //     foreach mime:Entity part in bodyParts {
    //         // Retrieve file contents
    //         mime:ContentDisposition content = part.getContentDisposition();
    //         string fileName = content.fileName;

    //         string path = string `./uploads/${fileName}`;

    //         byte[] fileContent = check part.getByteArray();

    //         // Write the file contents to the server file
    //         check io:fileWriteBytes(path, fileContent); // Sensitive

    //         // Return success message if upload was successful
    //         return string `File ${fileName} was uploaded successfully!`;
    //     }

    //     return "File upload failed!";
    // }

    // Compliant
    resource function post fileUpload(http:Request request) returns string|error {
        mime:Entity[] bodyParts = check request.getBodyParts();

        foreach mime:Entity part in bodyParts {
            // Retrieve file contents
            mime:ContentDisposition content = part.getContentDisposition();
            string fileName = content.fileName;

            string path = string `./uploads/${fileName}`;

            byte[] fileContent = check part.getByteArray();

            int maxUploadSize = 1024 * 1024 * 8; // 8MB
            int fileSize = fileContent.length();

            if (fileSize > maxUploadSize) {
                return "File size exceeds the maximum upload size!";
            }

            // Write the file contents to the server file
            check io:fileWriteBytes(path, fileContent);

            // Return success message if upload was successful
            return "File " + fileName + " was uploaded successfully!";
        }

        return "File upload failed!";
    }
}
