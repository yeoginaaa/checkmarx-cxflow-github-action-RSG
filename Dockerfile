#Use CxFlow Base image

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

COPY /home/hernan/Downloads/alawpcxmgr201.crt /etc/ssl/certs/

USER root
RUN $JAVA_HOME/bin/keytool -import -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -noprompt -file /etc/ssl/certs/alawpcxmgr201.crt -alias cx

FROM checkmarx/cx-flow
#Apply any updates
RUN apk update && apk upgrade
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
