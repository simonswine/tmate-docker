#!/bin/bash

# fail on first error
set -e

key_dir="/etc/tmate-slave/keys"
key_algorithms="rsa dsa ecdsa"

# read env variables
port=${PORT:-2222}

if [ -z "${HOST}" ]; then
    hostopt=""
    host="<hostname>"
else
    hostopt="-h ${HOST}"
    host=$HOST
fi

# ensure directory exists
mkdir -p $key_dir
chmod 700 $key_dir

# check for key per algorithm
for alg in $key_algorithms; do
    # ensure key exists
    path="${key_dir}/ssh_host_${alg}_key"
    if [ ! -e $path ]; then
        echo "Key ${alg} not found, generate one"
        ssh-keygen -t ${alg} -f "${path}" -N ''
    fi
    # ensure rights
    chmod 600 $path


 

echo Add this to your \~/.tmate.conf file
echo "set -g tmate-server-host \"${host}\""
echo "set -g tmate-server-port \"${port}\""
echo "set -g tmate-identity \"\""              # Can be specified to use a different SSH key.
for alg in $key_algorithms; do
    path="${key_dir}/ssh_host_${alg}_key"
    fingerprint=`ssh-keygen -l -f ${path} 2>&1 | cut -d\  -f 2`
    echo "set -g tmate-server-${alg}-fingerprint \"${fingerprint}\""
done

exec /usr/local/bin/tmate-slave -k ${key_dir} $hostopt -p ${port}
