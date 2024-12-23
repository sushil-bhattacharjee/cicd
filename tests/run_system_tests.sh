#!/bin/bash

# Check if appnet exists, if not create it
docker network inspect appnet > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "Creating Docker network appnet..."
    docker network create --subnet=172.20.0.0/24 --gateway=172.20.0.1 appnet
    if [[ $? -ne 0 ]]; then
        echo "Failed to create Docker network appnet. Exiting."
        exit 1
    fi
fi

# Run containers
echo "Starting containers..."
DOCKER_LB_ID=`docker run --net appnet --ip 172.20.0.10 -p 8090:8090 -itd 10.1.10.98:5005/root/cicd/lb`
DOCKER_APP1_ID=`docker run --net appnet --ip 172.20.0.100 -itd 10.1.10.98:5005/root/cicd/app`
DOCKER_APP2_ID=`docker run --net appnet --ip 172.20.0.101 -itd 10.1.10.98:5005/root/cicd/app`

sleep 5

# Run tests
python3 tests/system_tests.py
EXIT_CODE=$?

# Cleanup containers
echo "Cleaning up..."
docker stop $DOCKER_LB_ID
docker rm $DOCKER_LB_ID
docker stop $DOCKER_APP1_ID
docker rm $DOCKER_APP1_ID
docker stop $DOCKER_APP2_ID
docker rm $DOCKER_APP2_ID

exit $EXIT_CODE
