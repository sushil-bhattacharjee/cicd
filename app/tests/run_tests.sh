#! /bin/bash

DOCKER_ID=$(docker run -d -p 9000:9000 app)
sleep 5

python3 app_tests.py
EXIT_CODE=$?

docker kill $DOCKER_ID
docker rm $DOCKER_ID
exit $EXIT_CODE