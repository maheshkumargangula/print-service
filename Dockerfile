FROM circleci/node:8.11.2-stretch as build
MAINTAINER "Mahesh Kumar Gangula" "mahesh@ilimi.in"
USER root
COPY src /opt/print-service/
WORKDIR /opt/print-service/
RUN npm install

FROM node:8.11-slim
MAINTAINER "Mahesh Kumar Gangula" "mahesh@ilimi.in"
RUN apt-get clean \
    && useradd -m sunbird
USER sunbird
COPY --from=build --chown=sunbird /opt/print-service/ /home/sunbird/print-service/
WORKDIR /home/sunbird/print-service/
CMD ["node", "app.js", "&"]