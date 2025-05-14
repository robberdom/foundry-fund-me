# FundMe Smart Contract

This project contains a simple decentralized crowdfunding contract written in Solidity, designed to accept ETH contributions and allow the contract owner to withdraw the funds. It uses Chainlink price feeds to ensure a minimum contribution amount in USD.

---

## 📜 Overview

The `FundMe` contract allows users to fund it with ETH. However, it requires each contribution to meet a minimum USD value (converted from ETH using Chainlink's real-time price feed).

### Key Features

* **Minimum Contribution**: Users must send at least \$5 worth of ETH.
* **Owner-Only Withdrawals**: Only the deployer (owner) of the contract can withdraw funds.
* **Chainlink Integration**: Uses Chainlink's AggregatorV3Interface to fetch live ETH/USD prices.
* **Receive & Fallback**: Accepts plain ETH transfers via `receive()` and `fallback()` functions.

---

## 📦 Contracts

### `FundMe.sol`

* Stores funders and their contributions.
* Enforces a minimum contribution in USD.
* Allows only the contract owner to withdraw all funds.
* Resets funder records after withdrawal.

### `PriceConverter.sol` (Library)

* Provides utility functions to:

  * Fetch the latest ETH/USD price.
  * Convert ETH to USD based on the live price.

---

## 🔧 Usage

### Funding the Contract

```solidity
fundMe.fund{value: msg.value}();
```

* Requires `msg.value` to be at least \$5 worth of ETH at current rates.

### Withdrawing Funds

```solidity
fundMe.withdraw();
```

* Only the contract owner can call this.

---


## 🧠 Learnings & Design Notes

* **Immutable/Constant**: Used `immutable` for the owner and `constant` for the minimum USD value for gas savings.
* **Gas Optimizations**: Memory arrays are used for gas-efficient looping during withdrawals.
* **Custom Errors**: Used `FundMe__NotOwner()` for better error handling than strings.

---

## ✅ Prerequisites

* [Foundry](https://book.getfoundry.sh/) installed
* RPC URL and Chainlink Price Feed address (e.g., Sepolia)
* Optional: Etherscan API key for contract verification

---

## 📄 License

This project is licensed under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html).

---
