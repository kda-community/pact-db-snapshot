#!/bin/bash
set -euo pipefail

CHAINS="0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19"

REPOS=kda-community/pact-db-snapshot
TAG="dbdump-$(date +%Y-%m-%d)"
export REPOS

gh release create "$TAG" --repo $REPOS --title "Kadena DB dump - $(date +%Y-%m-%d)" 

for chain in $CHAINS; do
    db="pact-v1-chain-$chain".sqlite
    echo "Chain: $chain"
    echo "Compressing $db"
    cat "$db" | xz -9 -T2 | split -b 1800M -d -a 2 --filter='cat > $FILE && echo "Hadnling $FILE" && sha256sum $FILE >>SHA256SUMS_PARTS && gh release upload '"$TAG"' $FILE --repo "$REPOS" && rm $FILE' - "$db.xz.part-"

done
