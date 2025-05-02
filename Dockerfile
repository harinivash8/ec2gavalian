FROM maven:3.8.6-openjdk-17-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/twig-0.0.4-jar-with-dependencies.jar /app/twig.jar
CMD ["java", "-jar", "/app/twig.jar"]
