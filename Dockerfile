# Maven 빌드 스테이지
# 1단계: 빌드
FROM maven:3.9.4-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# 2단계: 톰캣 이미지에 배포
FROM tomcat:10.1-jdk17-temurin
COPY --from=builder /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
