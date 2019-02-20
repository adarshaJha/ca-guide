cd org0/orderer
rm genesis.block channel.tx mychannel.block
configtxgen -profile OrgsOrdererGenesis -outputBlock genesis.block
configtxgen -profile OrgsChannel -outputCreateChannelTx channel.tx -channelID mychannel
