#!/bin/bash

if [ -z "$REGION" ]; then
    echo "REGION variable not set. exiting..."
    exit 1
fi

if [ -z "$SQS_QUEUE_URL" ]; then
    echo "SQS_QUEUE_URL variable not set. exiting..."
    exit 1
fi

cd /opt/publisher

npm start