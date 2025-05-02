# Build stage with Java 17
FROM maven:3.8.6-openjdk-17-slim AS build

WORKDIR /app
COPY . .

# Build the Java project
RUN mvn clean  -DskipTests

# Runtime stage (optional)
FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/*.jar /app/twig.jar

CMD ["java", "-jar", "/app/twig.jar"]
