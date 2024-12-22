# Use Alpine Linux as the base image
FROM alpine:3.10

# Maintainer information
LABEL maintainer="Techie_Horizon"

# Set environment variables for Tomcat and Java versions
ENV TOMCAT_VERSION=9.0.73 \
    JAVA_PACKAGE=openjdk11 \
    CATALINA_HOME=/usr/local/tomcat

# Create directory for Tomcat
RUN mkdir -p $CATALINA_HOME

# Set working directory
WORKDIR $CATALINA_HOME

# Install dependencies, download and set up Tomcat, and clean up
RUN apk --no-cache add curl tar && \
    curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz --strip-components=1 && \
    rm -rf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    apk add --no-cache ${JAVA_PACKAGE}

# Copy the application WAR file into Tomcat's webapps directory
COPY /root sample.war $CATALINA_HOME/webapps/

# Expose Tomcat's default port
EXPOSE 8080

# Set default command to run Tomcat
CMD ["bin/catalina.sh", "run"]
