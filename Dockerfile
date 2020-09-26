FROM adoptopenjdk/openjdk11:alpine-slim

COPY ./target/gcptest-1.0-SNAPSHOT.jar /gcptest-1.0-SNAPSHOT.jar

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-Dserver.port=${PORT}", "-jar", "/gcptest-1.0-SNAPSHOT.jar"]
