FROM eclipse-temurin:21-jdk

WORKDIR /app
COPY . /app
RUN ./mvnw clean package
CMD ["java", "-jar", "target/twig-*.jar"]
