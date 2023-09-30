# Token for sonarqube analysis
- First generate a sonarqube token to make a project analyzable

```text
SONARQUBE_TOKEN: sqp_e12d7f7d420495555679aaafa05e3c5f39800d3c
```

- Replace the places mentioned as SONARQUBE_TOKEN with the actual token in the following guide

# Utilizing the Sonar Scanner for gradle for performing analysis

1. Set up the build.gradle file

```build.gradle
plugins {
  id "org.sonarqube" version "4.2.1.3168"
}
```

2. Execute the following code in the cmd

```cmd
./gradlew sonar
  -Dsonar.projectKey=sonarqube-kotlin-project
  -Dsonar.host.url=http://localhost:9000
  -Dsonar.token=SONARQUBE_TOKEN
```

3. Alternatively you can set those in as a gradle task

```build.gradle
sonar {
    properties {
        property("sonar.projectKey", "sonarqube-kotlin-project")
        property("sonar.host.url", "http://localhost:9000")
    }
}
```

- then run the following command

```cmd
gradlew sonar -Dsonar.token=SONARQUBE_TOKEN
```

- OR

```cmd
set SONAR_TOKEN=SONARQUBE_TOKEN
gradlew sonar
```

## Notes regarding the gradle application plugin

1. this plugin automatically sets up the sonar properties required to
   do a proper analysis of code and send the results to the sonarQube server

2. without this plugin no scanning will work on its own

3. once executed, sonar scanner temporarily creates an analysis log that contains details
   of the scanners that are already coming ready with it, these analysers are the ones
   responsible for generating the reports that are then sent to sonarQube

# Utilizing the Sonar Scanner for performing analysis

1. Download the Sonar Scanner

2. Create a sonar-project.properties file in the root directory so that the scan will be triggered for the entire project

```properties
sonar.projectKey=sonarqube-kotlin-project
sonar.sources=.
sonar.host.url=http://localhost:9000
sonar.login=SONARQUBE_TOKEN
```

# Debugging a SonarQube Project

1. To debug a plugin that executes during the analysis perform the following steps: (Recommended for non compiled languages)
   - set the following sonar env variable with the debug option:
   ```cmd
   set SONAR_SCANNER_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=8000"
   ```
   
   - Run the sonar-scanner
   ```cmd
   sonar-scanner
   ```
   
2. Alternatively we can use the gradlew debugging feature as follows: (Suitable for sonar scanner for gradle projects)
   ```cmd
   gradlew sonar -Dorg.gradle.debug=true --no-daemon -Dorg.gradle.debug.port=8000
   ```
   
3. Create a breakpoint in the required java project class file with a java remote debug configuration set up

4. Click the debug icon, to start debugging