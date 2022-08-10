FROM openjdk:11-jdk-slim as Builder
WORKDIR source
ARG JAR_FILE=target/*-exec.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:11-jre-slim
WORKDIR app
COPY --from=builder source/dependencies/ source/spring-boot-loader/ source/snapshot-dependencies/ source/application/ ./
EXPOSE 9090
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]