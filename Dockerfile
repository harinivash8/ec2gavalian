# Use Alpine Linux as the base image
FROM alpine:3.18

# Install required tools: wget, git, tar, and maven
RUN apk add --no-cache wget git tar maven
 
# Set working directory
WORKDIR /opt
 
# Clone the Git repository
RUN git clone https://github.com/harinivash8/ec2gavalian.git
 
# Build the Maven project
WORKDIR /opt/ec2gavalian
RUN mvn clean package -DskipTests
 
# Create Tomcat directory and download Tomcat 11
WORKDIR /opt
RUN mkdir -p tomcat
WORKDIR /opt/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.6/bin/apache-tomcat-11.0.6.tar.gz
RUN tar -xzf apache-tomcat-11.0.6.tar.gz --strip-components=1
RUN rm apache-tomcat-11.0.6.tar.gz
 
# Ensure webapps directory exists
RUN mkdir -p /opt/tomcat/webapps/
 
# Copy the JAR file - we can see from the error it exists as twig-0.0.4.jar
RUN mkdir -p /opt/tomcat/webapps/ROOT/
RUN cp /opt/ec2gavalian/target/twig-0.0.4.war /opt/tomcat/webapps/ROOT/ec2gavalian.war

RUN mkdir -p /opt/tomcat/conf/Catalina/localhost/
RUN echo '<Context docBase="/opt/tomcat/webapps/ROOT/ec2gavalian.jar" path="/ec2gavalian" />' > /opt/tomcat/conf/Catalina/localhost/ec2gavalian.xml
 
# Expose port 8080
EXPOSE 8080
 
# Run Tomcat
CMD ["bin/catalina.sh", "run"]
