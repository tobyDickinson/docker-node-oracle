FROM node:14.15.0-stretch-slim

WORKDIR /home

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    curl \
    libaio1 \
    unzip \
    && curl https://download.oracle.com/otn_software/linux/instantclient/199000/instantclient-basic-linux.x64-19.9.0.0.0dbru.zip > instantclient-basic-linux.zip \
    && curl https://download.oracle.com/otn_software/linux/instantclient/199000/instantclient-sdk-linux.x64-19.9.0.0.0dbru.zip > instantclient-sdk-linux.zip \
    && mkdir -p /opt/oracle \
    && unzip instantclient-basic-linux.zip -d /opt/oracle \
    && unzip instantclient-sdk-linux.zip -d /opt/oracle \
    && rm instantclient* \
    && mv /opt/oracle/instantclient_19_9 /opt/oracle/instantclient \
    && echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf \
    && ldconfig

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"

WORKDIR /usr/src/app
