# Stage 1: Build Stage (Uses a JDK for compilation)
# Use a Maven image with a valid JDK 8 environment
FROM maven:3.9.6-jdk-8 AS build 

WORKDIR /app

# Copy pom.xml and download dependencies first
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build
COPY src ./src
RUN mvn clean install -DskipTests

# Stage 2: Runtime Stage (Uses a JRE for execution)
# Use a lightweight JRE 8 image (e.g., Eclipse Temurin JRE)
FROM eclipse-temurin:8-jre-alpine 

# Set metadata and working directory
LABEL maintainer="Ayush Verma"
WORKDIR /app

# Copy the JAR from the 'build' stage
COPY --from=build /app/target/*.jar app.jar 

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]