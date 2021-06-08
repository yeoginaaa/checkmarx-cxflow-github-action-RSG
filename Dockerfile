#Use CxFlow Base image
FROM checkmarx/cx-flow
#Apply any updates
RUN apk update && apk upgrade

#Test Jun 8
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*
CMD /bin/bash
COPY checkmarx.crt /usr/local/share/ca-certificates/ca-certificates.crt
RUN apk add --no-cache ca-certificates && \
    update-ca-certificates
RUN chmod 644 /usr/local/share/ca-certificates/ca-certificates.crt && update-ca-certificates
RUN curl "https://alawpcxmgr201.risk.regn.net/cxwebclient/Scans.aspx"


#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
