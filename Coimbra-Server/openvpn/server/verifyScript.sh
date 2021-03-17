#!/bin/bash
# if the depth is non-zero , continue processing 
[ "$1" -ne 0 ] && exit 0

ocsp_url="http://10.2.0.2:9999" 
if [ -n "${tls_serial_0}" ]
then
    status=$(openssl ocsp -issuer /home/johnloyal/Documents/PROJETO_CA/ca.crt -CAfile /home/johnloyal/Documents/PROJETO_CA/ca.crt -url "$ocsp_url" -serial "0x${tls_serial_0}" 2>/dev/null)
    if [ $? -eq 0 ] 
	then
        # debug:
        echo "OCSP status: $status"
        if echo "$status" | grep -Fq "0x${tls_serial_0}: good" 
        then
            exit 0
	elif echo "$status" | grep -Fq "0x${tls_serial_0}: revoked"
	then
	    exit 1 
    	fi 
    else
        # debug:
        echo "openssl ocsp command failed!"
    fi
fi 
exit 1
