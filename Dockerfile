#Use CxFlow Base image
FROM checkmarx/cx-flow
#Apply any updates
RUN apk update && apk upgrade

#Test Jun 8
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*
CMD /bin/bash


RUN apk update && apk add curl
WORKDIR /usr/local/share/ca-certificates
RUN curl -ks 'https://raw.githubusercontent.com/hernan-soto/checkmarx-cxflow-github-action-RSG/master/checkmarx.crt' -o '/usr/local/share/ca-certificates/EnterpriseRootCA.crt'
RUN curl -ks 'https://raw.githubusercontent.com/hernan-soto/checkmarx-cxflow-github-action-RSG/master/checkmarx.cert' -o '/usr/local/share/ca-certificates/checkmarx.cert'
RUN /usr/sbin/update-ca-certificates
RUN keytool -importcert -keypass changeit -file EnterpriseRootCA.crt -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -noprompt -storepass changeit
RUN keytool -import -trustcacerts -alias localca -file checkmarx.cert -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -storepass changeit -noprompt

RUN curl "https://alawpcxmgr201.risk.regn.net/"


#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
