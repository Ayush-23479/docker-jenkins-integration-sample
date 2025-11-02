FROM openjdk:17-jre-slim

EXPOSE 8080

ADD target/docker-jenkins-integration-sample.jar docker-jenkins-integration-sample.jar
# Define the command to run the application when the container starts
# Use the full path to the JAR to be explicit
ENTRYPOINT ["java", "-jar", "docker-jenkins-integration-sample.jar"]