#!/bin/bash
docker build -t='scottjab/registry' .
docker run -d -p 5000:5000 scottjab/registry
docker pull nodeos/nodeos
docker tag nodeos/nodeos localhost:5000/nodeos
docker push localhost:5000/nodeos
echo "Nodeos should be mirroed, have people run docker pull <ipaddress>:5000/nodeos"

