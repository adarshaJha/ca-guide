#!/bin/sh

export FABRIC_LOGGING_SPEC=debug
export CORE_PEER_ADDRESS=peer1-org2:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/peer1/msp

mkdir /opt/gopath/src/github.com/hyperledger/fabric-samples
cp -r /tmp/hyperledger/org2/peer1/chaincode/ /opt/gopath/src/github.com/hyperledger/fabric-samples/

peer chaincode install -n mycc -v 1.0 -p github.com/hyperledger/fabric-samples/chaincode/abac/go
