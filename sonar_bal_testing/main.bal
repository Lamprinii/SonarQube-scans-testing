// ================================
// Ballerina Service related checks
// ================================
// import sonar_bal_testing.insecureEndpoint as _;
// import sonar_bal_testing.sqlInjection as _;
// import sonar_bal_testing.noSQLInjection as _;
// import sonar_bal_testing.functionPathInjection as _;
// import sonar_bal_testing.serverSideRequestForgery as _;
// import sonar_bal_testing.securitySensitiveHttpRequest as _;
// import sonar_bal_testing.requestRedirectionForging as _;
// import sonar_bal_testing.sensitiveSystemCommandArguments as _;
// import sonar_bal_testing.sensitiveEnumaration as _;
// import sonar_bal_testing.requestWithExcessiveContent as _;
// import sonar_bal_testing.disclosingFingerprints as _;
// import sonar_bal_testing.autoEscapeDisabledTemplateRendering as _;
// import sonar_bal_testing.permissiveCORS as _;
// import sonar_bal_testing.httpSensitiveCookies as _;
// import sonar_bal_testing.secureFlagSensitiveCookies as _;
import sonar_bal_testing.plainTextPasswordSaving as _;

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
// import sonar_bal_testing.osCommandsInPath;
// import sonar_bal_testing.securitySensitiveHardCodedIPs;

// For engaging custom rules compiler plugin [bal scan tool] (Only enable when performing static code analysis)
// import tharana_wanigaratne/compiler_plugin_customRules as _;

// For engaging custom rules compiler plugin [bal bridge tool] (Only enable when performing static code analysis)
// import tharana_wanigaratne/custom_compiler_plugin as _;

public function main() {
    // ==============================
    // Other Ballerina related checks
    // ==============================
    // tooManyParameters:checkRule();
    // panicChecker:checkRule();
    // emptyFunction:checkRule();
    // credentialsNotHardCoded:checkRule();
    // weakHashingAlgorithms:checkRule();
    // insecureDBConnection:connectToDatabase();
    // publicWritableDirectories:checkRule();
    // osCommandsInPath:checkRule();
    // securitySensitiveHardCodedIPs:checkRule();
}
