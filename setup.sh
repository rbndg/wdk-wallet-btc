#!/bin/bash

set -e

BITCOIN_VERSION="26.0"
wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz
tar -xzf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz
mv bitcoin-${BITCOIN_VERSION}/bin/* /usr/local/bin/

mkdir -p ~/.bitcoin
cat <<EOF > ~/.bitcoin/bitcoin.conf
[regtest]
daemon=1
server=1
rpcuser=user
rpcpassword=pass
rpcport=18443
txindex=1
fallbackfee=0.0002
EOF

bitcoind -regtest

echo "Waiting for bitcoind to start..."
until bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getblockchaininfo > /dev/null 2>&1; do
  sleep 1
done
echo "Bitcoind is ready."

bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass createwallet "testwallet"
ADDRESS=$(bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass getnewaddress)
bitcoin-cli -regtest -rpcuser=user -rpcpassword=pass generatetoaddress 101 "$ADDRESS"

echo "Generated 101 blocks to $ADDRESS. bitcoind is fully ready for testing."
