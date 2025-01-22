FROM maven:3-amazoncorretto-21-alpine AS build

WORKDIR /app

COPY pom.xml ./
COPY src ./src

RUN mvn clean install -Pprod

FROM amazoncorretto:21-alpine3.20 AS runtime

COPY --from=build /app/target/*.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]