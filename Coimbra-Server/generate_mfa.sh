#!/bin/sh
user_id=$1
MFA_USER=gauth
MFA_DIR=/etc/openvpn/google-authenticator
MFA_LABEL='OpenVPN Server'

if [$user_id == ""]
	then
		echo "Error"
		exit 1
fi

echo "INFO : creating user ${user_id}"

useradd -s /bin/nologin "$user_id"

echo "> please provide a password for the user"

passwd "$user_id"

echo "Info: Generating MFA token"

su -c "google-authenticator -t -d -r3 -R30 -W -f -l \"${MFA_LABEL}\" -s $MFA_DIR/${user_id}" - $MFA_USER

