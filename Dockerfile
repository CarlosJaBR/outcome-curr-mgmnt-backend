FROM maven:3.9.9-eclipse-temurin-17 AS build

#Workspace
WORKDIR /app

#Source
COPY . .

# Use maven command
RUN chmod +x mvnw

# Copy and install custom JAR
COPY libs/ojdbc6-11.2.0.3.jar /app/libs/ojdbc6-11.2.0.3.jar
RUN mvn install:install-file \
    -Dfile=/app/libs/ojdbc6-11.2.0.3.jar \
    -DgroupId=oracle \
    -DartifactId=ojdbc6 \
    -Dversion=11.2.0.3 \
    -Dpackaging=jar

# Clean and Install with maven
RUN mvn clean install


# Use the image for the runtime
FROM eclipse-temurin:17-jre

# workspace
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/outcome-curr-mgmt/target/outcome-curr-mgmt-1.0-SNAPSHOT.jar /app/outcurr-app.jar

EXPOSE 8080

# Run the Spring Boot app
CMD ["java", "-jar", "/app/outcurr-app.jar"]
