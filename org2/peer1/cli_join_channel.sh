#!/bin/sh

export FABRIC_LOGGING_SPEC=debug
export CORE_PEER_ADDRESS=peer1-org2:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/peer1/msp

peer channel join -b /tmp/hyperledger/org1/orderer/mychannel.block 

export CORE_PEER_ADDRESS=peer2-org2:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/peer2/msp
peer channel join -b /tmp/hyperledger/org1/orderer/mychannel.block 
