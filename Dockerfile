#Use CxFlow Base image
FROM checkmarx/cx-flow
#Apply any updates
RUN apk update && apk upgrade

#Test Jun 8
COPY /home/hernan/localcert.cert /usr/local/share/ca-certificates/checkmarx.cert
RUN chmod 644 /usr/local/share/ca-certificates/checkmarx.cert && update-ca-certificates


#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
