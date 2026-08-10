## Pact Full DB Snapshot

Non-compacted Pact Datanse

To restore the db:
- Download parts from release

```shell
cat pact-v1-chain-XX.sqlite.xz.part-* | xz -d > pact-v1-XX.sqlite
```

where XX is the chain ID (from 0 to 19)
