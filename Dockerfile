# Build stage using Maven
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN ./mvnw clean package -DskipTests

# Run stage using official Eclipse Temurin Java 17 runtime
FROM eclipse-temurin:17-jre-alpine
COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]