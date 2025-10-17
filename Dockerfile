# --- Build stage ---
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# --- Run stage ---
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Download Tomcat webapp-runner (lightweight servlet container)
ADD https://repo1.maven.org/maven2/com/github/jsimone/webapp-runner/9.0.85.0/webapp-runner-9.0.85.0.jar webapp-runner.jar

# Copy the built WAR file into container
COPY --from=build /app/target/*.war app.war

EXPOSE 8080
CMD ["java", "-jar", "webapp-runner.jar", "--port", "8080", "app.war"]
