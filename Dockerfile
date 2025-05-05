FROM tomcat:9.0-jdk21-temurin

# Remove default webapps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR to Tomcat's webapps directory
mvn clean package -DskipTests

EXPOSE 8080

CMD ["catalina.sh", "run"]
