# dsd-oracle-helper

solidity helper for getting dsd price

**1) get private vars using getStorageAt**

```
import { AbiCoder } from "ethers/lib/utils";

const timestampEncoded = await ethersProvider.getStorageAt(
  oracle.address,
  "0x5"
);

const timestampEncoded = await ethersProvider.getStorageAt(
  oracle.address,
  "0x5"
);
const timestamp = coder.decode(["uint256"], timestampEncoded);

const cumultativeEncoded = await ethersProvider.getStorageAt(
  oracle.address,
  "0x4"
);
const cumulative = coder.decode(["uint256"], cumultativeEncoded);

```

**2) send values into get getPrice**

```
getPrice(
  0x66e33d2605c5fb25ebb7cd7528e7997b0afa55e8,
  1,
  timestamp,
  cumulative
)
```
