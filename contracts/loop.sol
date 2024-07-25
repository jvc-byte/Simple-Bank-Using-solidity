// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Loop {
    uint8[] x;

    function loop() public returns (uint8[] memory) {
        uint8 i;
        // for loop
        for (i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip to next iteration with continue
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }
            x.push(i);
        }
        return x;
    }
}
