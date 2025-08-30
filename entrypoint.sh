#!/usr/bin/env sh

if [ -z "$SAMBA_PASSWORD" ]; then
    SAMBA_PASSWORD=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 32)
    echo "Generated random SAMBA_PASSWORD: $SAMBA_PASSWORD"
    echo "If you want to provide your own password set SAMBA_PASSWORD environment variable"
else
    echo "Using provided SAMBA_PASSWORD"
fi

echo "Creating user ${SAMBA_USERNAME}"
addgroup -g 1000 ${SAMBA_USERNAME} && \
    adduser -D -u 1000 -G ${SAMBA_USERNAME} -s /bin/sh ${SAMBA_USERNAME}

echo "Changing password for ${SAMBA_USERNAME}"
echo "${SAMBA_USERNAME}:${SAMBA_PASSWORD}" | chpasswd

echo "Add Samba user ${SAMBA_USERNAME}"
echo -e "${SAMBA_PASSWORD}\n${SAMBA_PASSWORD}\n" | smbpasswd -a -s ${SAMBA_USERNAME}

echo "Setting username in /etc/smb.conf ${SAMBA_USERNAME}"
sed -i "s/SAMBA_USERNAME/$SAMBA_USERNAME/g" /etc/samba/smb.conf

# Create logfile and symlink to main process
touch /var/log/samba.log
ln -sf /proc/1/fd/1 /var/log/samba.log

/usr/sbin/smbd --foreground --no-process-group
