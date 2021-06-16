#Use CxFlow Base image
FROM checkmarx/cx-flow


WORKDIR /app
RUN apk update && apk add curl
RUN curl -ks 'https://raw.githubusercontent.com/hernan-soto/checkmarx-cxflow-github-action-RSG/master/checkmarx.crt' -o 'checkmarx.crt'

COPY checkmarx.crt /app
RUN keytool -keystore /etc/ssl/certs/java/cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias checkmarx -file /app/checkmarx.crt




#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
