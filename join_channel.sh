#!/bin/sh

export FABRIC_LOGGING_SPEC=debug

export CORE_PEER_ADDRESS=peer1-org1:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org1/admin/msp
export CORE_PEER_LOCALMSPID=org1MSP

peer channel create -c mychannel -f /tmp/hyperledger/org0/orderer/channel.tx -o orderer1-org0:7050 --outputBlock /tmp/hyperledger/org0/orderer/mychannel.block --tls --cafile /tmp/hyperledger/org0/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem

peer channel join -b /tmp/hyperledger/org0/orderer/mychannel.block

export CORE_PEER_ADDRESS=peer2-org1:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org1/admin/msp
peer channel join -b /tmp/hyperledger/org0/orderer/mychannel.block

export CORE_PEER_ADDRESS=peer1-org2:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/admin/msp
export CORE_PEER_LOCALMSPID=org2MSP

peer channel join -b /tmp/hyperledger/org0/orderer/mychannel.block 

export CORE_PEER_ADDRESS=peer2-org2:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/admin/msp
peer channel join -b /tmp/hyperledger/org0/orderer/mychannel.block 
