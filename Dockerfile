FROM alpine:3.14

ENV SAMBA_USERNAME=samba

RUN apk add --no-cache samba sed
RUN mkdir /samba-data

COPY smb.conf /etc/samba/smb.conf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
