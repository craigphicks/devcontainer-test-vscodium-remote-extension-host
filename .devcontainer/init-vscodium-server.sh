#!/bin/bash
set -xe

if ! pidof codium-server > /dev/null 2>&1; then

    # Start VSCodium server
    echo "Starting VSCodium Remote Server..."
    nohup "/home/${USERNAME}/.${SERVER_INSTALL_NAME}/bin/codium-server" \
        --host ${SERVER_PORT_IP} \
        --port ${SERVER_PORT} \
        --without-connection-token \
        --accept-server-license-terms \
        > /dev/null 2>&1 & 

    echo "VSCodium Remote Server running in background"

else
    echo -e "\nVSCodium server is already running.\n"
fi