#Use CxFlow Base image
FROM checkmarx/cx-flow
#Apply any updates
RUN apk update && apk upgrade
RUN apt-get install curl
RUN curl https://alawpcxmgr201.risk.regn.net/cxwebclient/Projects.aspx
#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
