FROM alpine/git:latest AS clone
RUN git clone https://github.com/srkdevops15/java_demo.git /app

FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY --from=clone /app .
RUN ls -lart
RUN mvn clean install
RUN ls -l webapp/target

FROM tomcat:8.0-alpine
COPY --from=build /app/webapp/target/webapp.war /usr/local/tomcat/webapps/webapp.war
