# Maven 빌드 스테이지
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app

# pom.xml 복사
COPY pom.xml .

# 소스 코드 복사
COPY src ./src

# maven-war-plugin 버전을 명시적으로 지정하여 빌드
RUN mvn clean package -DskipTests -Dmaven.war.plugin.version=3.3.2

# Tomcat 배포 스테이지
# Tomcat 배포 스테이지
FROM tomcat:10.1-jre17-temurin
# 빌드된 WAR 파일을 Tomcat의 webapps 디렉토리에 복사
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]