FROM tomcat:9.0-jdk21-temurin

# Remove default webapps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR to Tomcat's webapps directory
COPY /app/target/twig-*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
