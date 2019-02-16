#!/bin/sh

export FABRIC_LOGGING_SPEC=debug

export CORE_PEER_ADDRESS=peer1-org1:7051
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org1/admin/msp
export CORE_PEER_LOCALMSPID=org1MSP

# mkdir /opt/gopath/src/github.com/hyperledger/fabric-samples
# cp -r /tmp/hyperledger/org1/peer1/chaincode/ /opt/gopath/src/github.com/hyperledger/fabric-samples/

# peer chaincode install -n mycc -v 1.0 -p github.com/hyperledger/fabric-samples/chaincode/abac/go

# # TODO: set tls for org2 
# export CORE_PEER_ADDRESS=peer1-org2:7051
# export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/admin/msp
# export CORE_PEER_LOCALMSPID=org2MSP

# peer chaincode install -n mycc -v 1.0 -p github.com/hyperledger/fabric-samples/chaincode/abac/go

# peer chaincode instantiate -C mychannel -n mycc -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -o orderer1-org0:7050 --tls --cafile /tmp/hyperledger/org0/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem

# sleep 10

# # TODO: set tls for org1 
#peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

# export CORE_PEER_ADDRESS=peer1-org2:7051
# export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/admin/msp
# export CORE_PEER_LOCALMSPID=org2MSP
# peer chaincode invoke -C mychannel -n mycc -c '{"Args":["invoke","a","b","10"]}' --tls --cafile /tmp/hyperledger/org0/orderer/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem

peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'
