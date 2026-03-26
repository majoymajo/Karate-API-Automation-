@echo off
set JAVA_HOME=C:\Users\usuario\.jdk\jdk-17.0.16
set MAVEN_BIN=C:\Users\usuario\.gemini\antigravity\scratch\tools\maven\apache-maven-3.9.6\bin\mvn.cmd

if not exist "%MAVEN_BIN%" (
    echo Maven not found at %MAVEN_BIN%. Trying system 'mvn' instead.
    mvn test
) else (
    call "%MAVEN_BIN%" test
)

pause
