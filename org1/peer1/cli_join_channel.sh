#!/bin/sh

export FABRIC_LOGGING_SPEC=debug
export CORE_PEER_ADDRESS=peer1-org1:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org1/peer1/msp

peer channel create -c mychannel -f /tmp/hyperledger/org1/orderer/channel.tx -o orderer1-org1:7050
peer channel join -b /tmp/hyperledger/org1/orderer/mychannel.block 

export CORE_PEER_ADDRESS=peer2-org1:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org1/peer2/msp
peer channel join -b /tmp/hyperledger/org1/orderer/mychannel.block 
