FROM debapriyo/dockertest

ENV JAVA_VER 8
ENV JAVA_HOME C:\Program Files\Java\jdk1.8.0_91
RUN update-java-alternatives -s C:\Program Files\Java\jdk1.8.0_91

# Install maven
RUN apt-get update
RUN apt-get install -y maven

WORKDIR /dockertest/code

# Prepare by downloading dependencies
ADD pom.xml /dockertest/code/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /dockertest/code/src
RUN ["mvn", "package"]

EXPOSE 4567
CMD ["java", "-version"]
CMD ["java", "-jar", "target/dockertest-jar-with-dependencies.jar"]