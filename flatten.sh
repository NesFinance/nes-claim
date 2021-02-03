#!/usr/bin/env bash

mkdir -p flats
rm -rf flats/*
./node_modules/.bin/truffle-flattener contracts/Claim.sol > flats/Claim.sol
