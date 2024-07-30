// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract nonPrimeNumber {
    // Array to store non-prime numbers
    uint8[] nonPrimeNumbers;

    // Function to check if a number is prime
    function isPrime(uint8 num) private pure returns (bool) {
        // Numbers less than or equal to 1 are not prime
        if (num <= 1) return false;

        // 2 and 3 are prime numbers
        if (num == 2 || num == 3) return true;

        // Numbers divisible by 2 or 3 are not prime
        if (num % 2 == 0 || num % 3 == 0) return false;
        
        // Check for factors starting from 5 and incrementing by 6
        for (uint8 i = 5; i * i <= num; i += 6) {
            // Check if num is divisible by i or i + 2
            if (num % i == 0 || num % (i + 2) == 0) return false;
        }
        // If no divisors were found, num is a prime number
        return true;
    }

    // Function to find and return non-prime numbers within a given range
    function loop() public returns (uint8[] memory) {
        uint8 i;
        // Clear the previous results from the nonPrimeNumbers array
        delete nonPrimeNumbers;
        // Loop through numbers from 0 to 1
        for (i = 0; i <= 15; i++) {
            // If the number is prime, skip adding it to the array
            if (isPrime(i)) {
                continue;
            }
            // Add non-prime numbers to the array
            nonPrimeNumbers.push(i);
        }
        // Return the array of non-prime numbers
        return nonPrimeNumbers;
    }
}