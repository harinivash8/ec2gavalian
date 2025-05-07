FROM alpine:latest
RUN yum install openjdk:17 git maven
WORKDIR /opt
RUN git clone https://github.com/harinivash8/ec2gavalian.git
WORKDIR /opt/ec2gavalian
RUN mvn clean package
WORKDIR /opt
RUN mkdir tomcat
WORKDIR /opt/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.6/bin/apache-tomcat-11.0.6.tar.gz
RUN tar -xzf apache-tomcat-11.0.6.tar.gz
RUN cp /opt/ec2gavalian/target/*.jar /opt/tomcat/webapps/ec2gavalian.jar
EXPOSE 8080
CMD ["catalina.sh", "run"]
