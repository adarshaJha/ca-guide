#!/bin/bash

##############################################################################################################
##############################################################################################################
#################################################### tls ####################################################
##############################################################################################################
##############################################################################################################

# cp /tmp/hyperledger/tls-ca/crypto/ca-cert.pem /tmp/hyperledger/tls-ca/crypto/tls-ca-cert.pem
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/tls-ca/crypto/tls-ca-cert.pem
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/tls-ca/admin
# fabric-ca-client enroll -d -u http://tls-ca-admin:tls-ca-adminpw@0.0.0.0:7052
# fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u http://0.0.0.0:7052 
# fabric-ca-client register -d --id.name peer2-org1 --id.secret peer2PW --id.type peer -u http://0.0.0.0:7052
# fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u http://0.0.0.0:7052 
# fabric-ca-client register -d --id.name peer2-org2 --id.secret peer2PW --id.type peer -u http://0.0.0.0:7052
# fabric-ca-client register -d --id.name orderer1-org0 --id.secret ordererPW --id.type orderer -u http://0.0.0.0:7052 

##############################################################################################################
##############################################################################################################
#################################################### org0 ####################################################
##############################################################################################################
##############################################################################################################

# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org0/ca/crypto/ca-cert.pem
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org0/ca/admin

# fabric-ca-client enroll -d -u https://rca-org0-admin:rca-org0-adminpw@0.0.0.0:7053
# fabric-ca-client register -d --id.name orderer1-org0 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7053
# fabric-ca-client register -d --id.name admin-org0 --id.secret org0AdminPW --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u https://0.0.0.0:7053 

###############################################################################################################
#### Enroll Orderer ######################################
###############################################################################################################

# rm -r /tmp/hyperledger/org0/orderer/msp

# mkdir -p /tmp/hyperledger/org0/orderer/assets/ca
# cp /tmp/hyperledger/org0/ca/crypto/ca-cert.pem /tmp/hyperledger/org0/orderer/assets/ca/org0-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org0/orderer
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org0/orderer/assets/ca/org0-ca-cert.pem
# fabric-ca-client enroll -d -u https://orderer1-org0:ordererPW@0.0.0.0:7053
# mkdir /tmp/hyperledger/org0/orderer/msp/admincerts

###############################################################################################################
#### Get TLS Certificate #################################
###############################################################################################################

# rm -r /tmp/hyperledger/org0/orderer/tls-msp
# mkdir -p /tmp/hyperledger/org0/orderer/assets/tls-ca
# cp /tmp/hyperledger/tls-ca/crypto/ca-cert.pem /tmp/hyperledger/org0/orderer/assets/tls-ca/tls-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=tls-msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org0/orderer
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org0/orderer/assets/tls-ca/tls-ca-cert.pem
# fabric-ca-client enroll -d -u http://orderer1-org0:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-org0

# mv /tmp/hyperledger/org0/orderer/tls-msp/keystore/* /tmp/hyperledger/org0/orderer/tls-msp/keystore/key.pem

###############################################################################################################
#### Enroll Org0 Admin ###################################
###############################################################################################################

# rm -r /tmp/hyperledger/org0/admin/*

# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org0/admin
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org0/orderer/assets/ca/org0-ca-cert.pem
# fabric-ca-client enroll -d -u https://admin-org0:org0AdminPW@0.0.0.0:7053
# mkdir /tmp/hyperledger/org0/admin/msp/admincerts #### TODO: Is this needed?
# cp /tmp/hyperledger/org0/admin/msp/signcerts/cert.pem /tmp/hyperledger/org0/admin/msp/admincerts/admin-org0-cert.pem #### TODO: Is this needed?
# cp /tmp/hyperledger/org0/admin/msp/signcerts/cert.pem /tmp/hyperledger/org0/orderer/msp/admincerts/admin-org0-cert.pem

#mkdir -p ./org0/msp/admincerts ./org0/msp/cacerts ./org0/msp/tlscacerts ./org0/msp/users
#cp ./org0/admin/msp/signcerts/cert.pem ./org0/msp/admincerts/admin-org0-cert.pem
#cp ./org0/ca/crypto/ca-cert.pem ./org0/msp/cacerts/ca-cert.pem  
#cp ./tls/ca/crypto/ca-cert.pem ./org0/msp/tlscacerts/tls-ca-cert.pem

###############################################################################################################
###############################################################################################################
##################################################### org1 ####################################################
###############################################################################################################
###############################################################################################################

# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/ca/crypto/ca-cert.pem
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/ca/admin
# fabric-ca-client enroll -d -u https://rca-org1-admin:rca-org1-adminpw@0.0.0.0:7054
# fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7054 
# fabric-ca-client register -d --id.name peer2-org1 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7054
# fabric-ca-client register -d --id.name admin-org1 --id.secret org1AdminPW --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u https://0.0.0.0:7054 
# fabric-ca-client register -d --id.name user-org1 --id.secret org1UserPW --id.type user -u https://0.0.0.0:7054 

###############################################################################################################
#### Enroll Peer1 ######################################
###############################################################################################################

# rm -r /tmp/hyperledger/org1/peer1/msp
# rm -r /tmp/hyperledger/org1/peer1/tls-msp

# mkdir -p /tmp/hyperledger/org1/peer1/assets/ca
# cp /tmp/hyperledger/org1/ca/crypto/ca-cert.pem /tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/peer1
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem
# fabric-ca-client enroll -d -u https://peer1-org1:peer1PW@0.0.0.0:7054
# mkdir /tmp/hyperledger/org1/peer1/msp/admincerts

###############################################################################################################
#### Peer1 - Get TLS Certificate #################################
###############################################################################################################

# mkdir -p /tmp/hyperledger/org1/peer1/assets/tls-ca
# cp /tmp/hyperledger/tls-ca/crypto/ca-cert.pem /tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=tls-msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/peer1
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem
# fabric-ca-client enroll -d -u http://peer1-org1:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-org1

# mv /tmp/hyperledger/org1/peer1/tls-msp/keystore/* /tmp/hyperledger/org1/peer1/tls-msp/keystore/key.pem

###############################################################################################################
#### Enroll peer2 ######################################
###############################################################################################################

# rm -r /tmp/hyperledger/org1/peer2/msp
# rm -r /tmp/hyperledger/org1/peer2/tls-msp

# mkdir -p /tmp/hyperledger/org1/peer2/assets/ca
# cp /tmp/hyperledger/org1/ca/crypto/ca-cert.pem /tmp/hyperledger/org1/peer2/assets/ca/org1-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/peer2
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer2/assets/ca/org1-ca-cert.pem
# fabric-ca-client enroll -d -u https://peer2-org1:peer2PW@0.0.0.0:7054
# mkdir /tmp/hyperledger/org1/peer2/msp/admincerts

###############################################################################################################
#### Peer2 - Get TLS Certificate #################################
###############################################################################################################

# mkdir -p /tmp/hyperledger/org1/peer2/assets/tls-ca
# cp /tmp/hyperledger/tls-ca/crypto/ca-cert.pem /tmp/hyperledger/org1/peer2/assets/tls-ca/tls-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=tls-msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/peer2
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer2/assets/tls-ca/tls-ca-cert.pem
# fabric-ca-client enroll -d -u http://peer2-org1:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer2-org1

# mv /tmp/hyperledger/org1/peer2/tls-msp/keystore/* /tmp/hyperledger/org1/peer2/tls-msp/keystore/key.pem

###############################################################################################################
#### Enroll Org1 Admin ###################################
###############################################################################################################

# rm -r /tmp/hyperledger/org1/admin/*

# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/admin
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem
# fabric-ca-client enroll -d -u https://admin-org1:org1AdminPW@0.0.0.0:7054
# mkdir /tmp/hyperledger/org1/admin/msp/admincerts
# cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/admin/msp/admincerts/admin-org1-cert.pem
# cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/peer1/msp/admincerts/admin-org1-cert.pem
# cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/peer2/msp/admincerts/admin-org1-cert.pem

# mkdir -p ./org1/msp/admincerts ./org1/msp/cacerts ./org1/msp/tlscacerts ./org1/msp/users
# cp ./org1/admin/msp/signcerts/cert.pem ./org1/msp/admincerts/admin-org1-cert.pem
# cp ./org1/ca/crypto/ca-cert.pem ./org1/msp/cacerts/ca-cert.pem 
# cp ./tls/ca/crypto/ca-cert.pem ./org1/msp/tlscacerts/tls-ca-cert.pem
# cp ./org1/ca/crypto/msp/keystore ./org1/msp/ # TODO: IS THIS NEEDED?

###############################################################################################################
###############################################################################################################
##################################################### org2 ####################################################
###############################################################################################################
###############################################################################################################

###############################################################################################################
#### CA bootstrap
###############################################################################################################

# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/ca/crypto/ca-cert.pem
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/ca/admin
# fabric-ca-client enroll -d -u https://rca-org2-admin:rca-org2-adminpw@0.0.0.0:7055
# fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7055 
# fabric-ca-client register -d --id.name peer2-org2 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7055
# fabric-ca-client register -d --id.name admin-org2 --id.secret org2AdminPW --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u https://0.0.0.0:7055
# fabric-ca-client register -d --id.name user-org2 --id.secret org2UserPW --id.type user -u https://0.0.0.0:7055

###############################################################################################################
#### Enroll Peer1 ######################################
###############################################################################################################

# rm -r /tmp/hyperledger/org2/peer1/msp
# rm -r /tmp/hyperledger/org2/peer1/tls-msp

# mkdir -p /tmp/hyperledger/org2/peer1/assets/ca
# cp /tmp/hyperledger/org2/ca/crypto/ca-cert.pem /tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/peer1
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem
# fabric-ca-client enroll -d -u https://peer1-org2:peer1PW@0.0.0.0:7055
# mkdir /tmp/hyperledger/org2/peer1/msp/admincerts

###############################################################################################################
#### Get TLS Certificate #################################
###############################################################################################################

# mkdir -p /tmp/hyperledger/org2/peer1/assets/tls-ca
# cp /tmp/hyperledger/tls-ca/crypto/ca-cert.pem /tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=tls-msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/peer1
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem
# fabric-ca-client enroll -d -u http://peer1-org2:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-org2

# mv /tmp/hyperledger/org2/peer1/tls-msp/keystore/* /tmp/hyperledger/org2/peer1/tls-msp/keystore/key.pem

###############################################################################################################
#### Enroll Peer2 ######################################
###############################################################################################################

# rm -r /tmp/hyperledger/org2/peer2/msp
# rm -r /tmp/hyperledger/org2/peer2/tls-msp

# mkdir -p /tmp/hyperledger/org2/peer2/assets/ca
# cp /tmp/hyperledger/org2/ca/crypto/ca-cert.pem /tmp/hyperledger/org2/peer2/assets/ca/org2-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/peer2
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer2/assets/ca/org2-ca-cert.pem
# fabric-ca-client enroll -d -u https://peer2-org2:peer2PW@0.0.0.0:7055
# mkdir /tmp/hyperledger/org2/peer2/msp/admincerts

###############################################################################################################
#### Get TLS Certificate #################################
###############################################################################################################

# mkdir -p /tmp/hyperledger/org2/peer2/assets/tls-ca
# cp /tmp/hyperledger/tls-ca/crypto/ca-cert.pem /tmp/hyperledger/org2/peer2/assets/tls-ca/tls-ca-cert.pem
# export FABRIC_CA_CLIENT_MSPDIR=tls-msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/peer2
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer2/assets/tls-ca/tls-ca-cert.pem
# fabric-ca-client enroll -d -u http://peer2-org2:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer2-org2

# mv /tmp/hyperledger/org2/peer2/tls-msp/keystore/* /tmp/hyperledger/org2/peer2/tls-msp/keystore/key.pem

###############################################################################################################
#### Enroll Org2 Admin ###################################
###############################################################################################################

# rm -r /tmp/hyperledger/org2/admin/*
# export FABRIC_CA_CLIENT_MSPDIR=msp
# export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/admin
# export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem
# fabric-ca-client enroll -d -u https://admin-org2:org2AdminPW@0.0.0.0:7055
# mkdir /tmp/hyperledger/org2/admin/msp/admincerts
# cp /tmp/hyperledger/org2/admin/msp/signcerts/cert.pem /tmp/hyperledger/org2/admin/msp/admincerts/admin-org2-cert.pem
# cp /tmp/hyperledger/org2/admin/msp/signcerts/cert.pem /tmp/hyperledger/org2/peer1/msp/admincerts/admin-org2-cert.pem
# cp /tmp/hyperledger/org2/admin/msp/signcerts/cert.pem /tmp/hyperledger/org2/peer2/msp/admincerts/admin-org2-cert.pem

# mkdir -p ./org2/msp/admincerts ./org2/msp/cacerts ./org2/msp/tlscacerts ./org2/msp/users
# cp ./org2/admin/msp/signcerts/cert.pem ./org2/msp/admincerts/admin-org2-cert.pem
# cp ./org2/ca/crypto/ca-cert.pem ./org2/msp/cacerts/ca-cert.pem 
# cp ./tls/ca/crypto/ca-cert.pem ./org2/msp/tlscacerts/tls-ca-cert.pem
# cp ./org2/ca/crypto/msp/keystore ./org2/msp/

###############################################################################################################
#### gensis blocks ######################################
###############################################################################################################

### Create MSPs for Orderer ###

# rm -rf /tmp/hyperledger/org0/msp
# rm -rf /tmp/hyperledger/org1/msp
# rm -rf /tmp/hyperledger/org2/msp

# ## Org0 ##
# mkdir -p /tmp/hyperledger/org0/msp/cacerts
# cp /tmp/hyperledger/org0/ca/crypto/ca-cert.pem /tmp/hyperledger/org0/msp/cacerts/org0-ca-cert.pem

# mkdir -p /tmp/hyperledger/org0/msp/admincerts
# cp /tmp/hyperledger/org0/admin/msp/signcerts/cert.pem /tmp/hyperledger/org0/msp/admincerts/admin-org0-cert.pem

# mkdir -p /tmp/hyperledger/org0/msp/tlscacerts
# cp /tmp/hyperledger/tls-ca/crypto/tls-ca-cert.pem /tmp/hyperledger/org0/msp/tlscacerts/tls-ca-cert.pem

# ## Org1 ##
# mkdir -p /tmp/hyperledger/org1/msp/cacerts
# cp /tmp/hyperledger/org1/ca/crypto/ca-cert.pem /tmp/hyperledger/org1/msp/cacerts/org1-ca-cert.pem

# mkdir -p /tmp/hyperledger/org1/msp/admincerts
# cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/msp/admincerts/admin-org1-cert.pem

# mkdir -p /tmp/hyperledger/org1/msp/tlscacerts
# cp /tmp/hyperledger/tls-ca/crypto/tls-ca-cert.pem /tmp/hyperledger/org1/msp/tlscacerts/tls-ca-cert.pem

# ## Org2 ##
# mkdir -p /tmp/hyperledger/org2/msp/cacerts
# cp /tmp/hyperledger/org2/ca/crypto/ca-cert.pem /tmp/hyperledger/org2/msp/cacerts/org2-ca-cert.pem

# mkdir -p /tmp/hyperledger/org2/msp/admincerts
# cp /tmp/hyperledger/org2/admin/msp/signcerts/cert.pem /tmp/hyperledger/org2/msp/admincerts/admin-org2-cert.pem

# mkdir -p /tmp/hyperledger/org2/msp/tlscacerts
# cp /tmp/hyperledger/tls-ca/crypto/tls-ca-cert.pem /tmp/hyperledger/org2/msp/tlscacerts/tls-ca-cert.pem

# cp ./org0/orderer/configtx.yaml /tmp/hyperledger/org0/orderer
# cd /tmp/hyperledger/org0/orderer
# configtxgen -profile OrgsOrdererGenesis -outputBlock /tmp/hyperledger/org0/orderer/genesis.block
# configtxgen -profile OrgsChannel -outputCreateChannelTx /tmp/hyperledger/org0/orderer/channel.tx -channelID mychannel

# cp -r ./org1/peer1/chaincode /tmp/hyperledger/org1/peer1/assets/chaincode
# cp -r ./org1/peer1/chaincode /tmp/hyperledger/org2/peer1/assets/chaincode

cp /tmp/hyperledger/org1/peer1/assets/mychannel.block /tmp/hyperledger/org2/peer1/assets/mychannel.block
