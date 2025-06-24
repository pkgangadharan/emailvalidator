# Use official OpenJDK image
FROM openjdk:17-jdk-slim
VOLUME /tmp
COPY target/email-validator-1.0.0.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
