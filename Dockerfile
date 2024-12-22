FROM alpine:3.10
MAINTAINER rakesh pagidimarri
RUN mkdir -p /usr/local/tomcat/
WORKDIR /usr/local/tomcat
RUN apk --no-cache add curl && \
        curl -o apache-tomcat-9.0.98.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz && \
    tar -xvf apache*.tar.gz
RUN mv apache-tomcat-9.0.98/* /usr/local/tomcat/.
RUN rm -rf apache-*
COPY sample.war /usr/local/tomcat/webapps
RUN apk --no-cache add openjdk11
WORKDIR /usr/local/tomcat
EXPOSE 8080
CMD ["/usr/local/tomcatbin/catalina.sh", "run"]
