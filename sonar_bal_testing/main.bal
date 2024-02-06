// ================================
// Ballerina Service related checks
// ================================
// Insecure endpoint rule testing
// import sonar_bal_testing.insecureEndpoint as _;
// SQL Database injection rule testing
// import sonar_bal_testing.sqlInjection as _;
// NoSQL Database injection rule testing
// import sonar_bal_testing.noSQLInjection as _;
// Filepath injection rule testing
// import sonar_bal_testing.functionPathInjection as _;
// Server side request forgery rule testing
// import sonar_bal_testing.serverSideRequestForgery as _;
// Security sensitive HTTP request rule testing
// import sonar_bal_testing.securitySensitiveHttpRequest as _;
// Dynamic code injection rule testing
// import sonar_bal_testing.requestRedirectionForging as _;
// Request redirection forging rule testing
// import sonar_bal_testing.requestRedirectionForging as _;
// import sonar_bal_testing.sensitiveSystemCommandArguments as _;
import sonar_bal_testing.sensitiveEnumaration as _;

// ============================
// Ballerina Non service checks
// ============================
// import sonar_bal_testing.emptyFunction;
// import sonar_bal_testing.panicChecker;
// import sonar_bal_testing.tooManyParameters;
// import sonar_bal_testing.insecureEndpoint;
// import sonar_bal_testing.credentialsNotHardCoded;
// import sonar_bal_testing.weakHashingAlgorithms;
// import sonar_bal_testing.insecureDBConnection;
// import sonar_bal_testing.publicWritableDirectories;

// For engaging custom rules compiler plugin [bal scan tool] (Only enable when performing static code analysis)
// import tharana_wanigaratne/compiler_plugin_customRules as _;

// For engaging custom rules compiler plugin [bal bridge tool] (Only enable when performing static code analysis)
// import tharana_wanigaratne/custom_compiler_plugin as _;

public function main() {
    // ==============================
    // Other Ballerina related checks
    // ==============================
    // int result = tooManyParameters:checkRule(1, 2, 3, 4, 5, 6, 7, 8);
    // panicChecker:checkRule();
    // emptyFunction:checkRule();
    // credentialsNotHardCoded:checkRule();
    // weakHashingAlgorithms:checkRule();
    // insecureDBConnection:connectToDatabase();
    // publicWritableDirectories:checkRule();
}
