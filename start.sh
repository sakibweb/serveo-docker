#!/bin/sh

# Default values for environment variables
: "${LOCAL_HOST:=localhost}"
: "${LOCAL_PORT:=80}"
: "${REMOTE_PORT:=80}"
: "${CUSTOM_SUBDOMAIN:=}"
: "${SSH_USER:=serveo.net}"
: "${SSH_OPTIONS:="-o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=no"}"

# Build the SSH tunnel options
if [ -n "$CUSTOM_SUBDOMAIN" ]; then
    TUNNEL_OPTION="$CUSTOM_SUBDOMAIN:$REMOTE_PORT:$LOCAL_HOST:$LOCAL_PORT"
else
    TUNNEL_OPTION="$REMOTE_PORT:$LOCAL_HOST:$LOCAL_PORT"
fi

# Conditionally add SSH_OPTIONS if set
if [ -n "$SSH_OPTIONS" ]; then
    echo "Starting SSH tunnel with: autossh -M 0 $SSH_OPTIONS -R $TUNNEL_OPTION $SSH_USER"
    autossh -M 0 $SSH_OPTIONS -R $TUNNEL_OPTION $SSH_USER
else
    echo "Starting SSH tunnel with: autossh -M 0 -R $TUNNEL_OPTION $SSH_USER"
    autossh -M 0 -R $TUNNEL_OPTION $SSH_USER
fi
