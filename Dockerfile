#Use CxFlow Base image
FROM checkmarx/cx-flow
#Apply any updates
RUN apk update && apk upgrade

#Test Jun 8
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*
CMD /bin/bash


RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
COPY checkmarx.crt /etc/ssl/cert.pem
ADD checkmarx.crt /etc/ssl/certs/ca-certificates.crt
RUN update-ca-certificates

RUN curl "https://alawpcxmgr201.risk.regn.net/cxwebclient/Scans.aspx"


#Copy the entrypoint script and properties used for the action
COPY entrypoint.sh /app/entrypoint.sh
#Make it executable
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
