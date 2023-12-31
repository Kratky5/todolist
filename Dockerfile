FROM ubuntu:latest AS build 
# Atualize os repositórios de pacotes
RUN apt-get update 
# Instale o OpenJDK 17
RUN apt-get install openjdk-17-jdk -y
# Copie os arquivos do diretório local para o contêiner
COPY . .
# Instale o Maven
RUN apt-get install maven -y

RUN mvn clean install

FROM openjdk:17-jdk-slim
# Defina a porta em que o aplicativo será executado
EXPOSE 8080

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
