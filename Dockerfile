FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/twig-*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
