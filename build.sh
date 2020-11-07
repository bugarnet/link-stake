#!/usr/bin/env bash
echo 'set cwd..'
cd "$(dirname "$0")"
rm -rf cache
rm -rf artifacts
echo 'flattening StakingRewardsFactory...'
npx truffle-flattener contracts/StakingRewardsFactory.sol | awk '/SPDX-License-Identifier/&&c++>0 {next} 1' | awk '/pragma experimental ABIEncoderV2;/&&c++>0 {next} 1' >> flattened-contracts/StakingRewardsFactory.sol
cd flattened-contracts
echo 'Compiling flattened contracts...'
yarn compile
echo "Copying artifacts to Prodartifacts..."
cp -rf ./artifacts/contracts/StakingRewardsFactory.sol/StakingRewardsFactory.json prodartifacts/StakingRewardsFactory.json
echo 'done!'
