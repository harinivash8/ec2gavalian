# Use Maven to build the project
FROM maven:3.8.5-openjdk-11 AS build

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Run Maven build
RUN mvn clean package -DskipTests

# Now create a runtime image
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy JAR file from previous stage
COPY --from=build /app/target/twig-0.0.4.jar /app/twig.jar

# Expose port (change if necessary)
EXPOSE 8080

# Run the app
CMD ["java", "-jar", "twig.jar"]
