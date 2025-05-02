FROM eclipse-temurin:21-jdk

WORKDIR /app
COPY . /app
RUN ./mvnw clean -DskipTests
EXPOSE 8000
CMD ["java", "-jar", "target/twig-*.jar"]
