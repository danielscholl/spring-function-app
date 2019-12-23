
FROM maven:3-jdk-8 AS installer-env

RUN mkdir -p /build
WORKDIR /build

COPY pom.xml /build
RUN mvn -B dependency:go-offline dependency:resolve dependency:resolve-plugins

COPY src /build/src
RUN mvn clean package

FROM mcr.microsoft.com/azure-functions/java:2.0 as runtime
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
  AzureFunctionsJobHost__Logging__Console__IsEnabled=true

COPY --from=installer-env ["/build/target/azure-functions/javafunctions", "/home/site/wwwroot"]

# EXPOSE 8080
# ENV APP_HOME /app
# ENV JAVA_OPTS=""

# RUN mkdir $APP_HOME

# WORKDIR $APP_HOME
# COPY --from=builder /build/target/*.jar app.jar




