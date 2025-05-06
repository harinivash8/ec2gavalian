
FROM eclipse-temurin:21-jdk-alpine

# Install required tools: wget, git, tar, and maven
RUN apk add --no-cache wget git tar maven

# Set working directory
WORKDIR /opt

# Clone the Git repository
RUN git clone https://github.com/harinivash8/ec2gavalian.git

# Build the Maven project
WORKDIR /opt/ec2gavalian
RUN mvn clean package -DskipTests

# Create Tomcat directory and download Tomcat 8.5.40
WORKDIR /opt
RUN mkdir tomcat
WORKDIR /opt/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.6/bin/apache-tomcat-11.0.6.tar.gz
RUN tar -xzf apache-tomcat-11.0.6.tar.gz --strip-components=1

# Copy WAR or JAR file to Tomcat's webapps directory (assuming WAR)
RUN cp /opt/ec2gavalian/target/*.war /opt/tomcat/webapps/ec2gavalian.war

# Expose port 8080
EXPOSE 8080

# Run Tomcat
CMD ["bin/catalina.sh", "run"]
