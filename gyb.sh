#!/bin/bash
set -e

mkdir -p BetterTG/Utilities/Generated
cd BetterTG/Utilities/Templates
find . -name "*.gyb" |
while read file; do
    filename=$(echo "$file" | sed 's/.\///')
    API_ID=$1 API_HASH=$2 gyb -o "../Generated/${filename%.gyb}" "$filename";
done

cd ../..

