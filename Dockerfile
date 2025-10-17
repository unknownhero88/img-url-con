# Use an official Maven + Java image to build your app
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

# Run the packaged WAR using webapp-runner
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target /app
CMD ["java", "-jar", "dependency/webapp-runner.jar", "--port", "8080", "imgurlcon.war"]
