# Build stage
FROM maven:3.9.5-eclipse-temurin-21-alpine AS build
WORKDIR /app

# Copy only the POM first to cache dependencies
COPY pom.xml .
# Try to download dependencies (will fail but populate local repo)
RUN mvn dependency:go-offline -Dmaven.repo.local=/app/.m2/repository || true

# Copy all source files
COPY src ./src

# Build the application (using offline mode)
RUN mvn -o clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/twig-*-core.jar app.jar

# Expose port (adjust as needed)
EXPOSE 8080

# Set the entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]
