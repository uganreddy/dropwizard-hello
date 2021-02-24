FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app/pom.xml
COPY hello-world.yml /home/app/hello-world.yml
WORKDIR /home/app/
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/helloworld-0.0.1-SNAPSHOT.jar /usr/local/lib/helloworld-0.0.1-SNAPSHOT.jar
COPY --from=build /home/app/hello-world.yml .
EXPOSE 8080
CMD ["java","-jar","/usr/local/lib/helloworld-0.0.1-SNAPSHOT.jar","server","hello-world.yml"]
