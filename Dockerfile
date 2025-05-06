# Use Alpine Linux as the base image
FROM alpine:3.18

# Install necessary packages: OpenJDK 17, Maven, Git, and wget
RUN apk add --no-cache openjdk17 maven git wget tar

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk \
    PATH=$JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /opt

# Clone your Git repository
RUN git clone https://github.com/harinivash8/ec2gavalian.git

# Build the Maven project and package it as a WAR file
WORKDIR /opt/ec2gavalian
RUN mvn clean package -DskipTests

# Create a directory for Tomcat and download Tomcat 11.0.6
WORKDIR /opt
RUN mkdir tomcat
WORKDIR /opt/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.6/bin/apache-tomcat-11.0.6.tar.gz \
    && tar -xzf apache-tomcat-11.0.6.tar.gz --strip-components=1 \
    && rm apache-tomcat-11.0.6.tar.gz

# Deploy the WAR file to Tomcat's webapps directory
RUN cp /opt/ec2gavalian/target/*.war /opt/tomcat/webapps/ec2gavalian.war

# Expose port 8080
EXPOSE 8080

# Set the working directory to Tomcat
WORKDIR /opt/tomcat

# Start Tomcat
CMD ["bin/catalina.sh", "run"]
