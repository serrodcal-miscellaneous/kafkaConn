FROM openjdk:8-jdk

ARG JAVA_OPTS="-Xms2048m -Xmx2048m"
ARG OSGI_CONSOLE_PORT=19444

ENV JAVA_OPTS ${JAVA_OPTS}
ENV OSGI_CONSOLE_PORT ${OSGI_CONSOLE_PORT}

COPY ./wso2esb-5.0.0.zip /opt

RUN groupadd -g 999 wso2esb && \
    useradd -r -u 999 -g wso2esb wso2esb && \
    apt-get update && \
    apt-get install -y zip && \
    apt-get clean && \
    unzip /opt/wso2esb-5.0.0.zip -d /opt && \
    chown -R wso2esb:wso2esb /opt/wso2esb-5.0.0 && \
    rm /opt/wso2esb-5.0.0.zip && \
    apt-get remove -y zip && \
    apt-get autoremove

EXPOSE 8280 8243 9763 9443 ${OSGI_CONSOLE_PORT}

USER wso2esb
WORKDIR /opt/wso2esb-5.0.0

COPY ./config/application.conf /opt/wso2esb-5.0.0/repository/conf/tpa/application.conf

CMD bin/wso2server.sh -DosgiConsole=${OSGI_CONSOLE_PORT} ${JAVA_OPTS} -Dconfig.file=/opt/wso2esb-5.0.0/repository/conf/tpa/application.conf
