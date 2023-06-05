# DAO Smart Contract Hardhat Project
This repository contains a smart contract project developed using the Hardhat framework for creating and testing Ethereum smart contracts. The project implements a Decentralized Autonomous Organization (DAO) using Solidity, allowing for decentralized governance and decision-making within a blockchain network.

## Installation

1. Clone the repository
    ```bash
    git clone https://github.com/subrotokumar/collegence-dao.git
    ```
2. Navigate to the project directory:
   ```bash
   cd collegence-dao/contracts
   ```
3. Install the dependencies:
   ```bash
   yarn
   ```
4. Configure the project:
   Rename `.env.example` to `.env` and update the values with your configuration.

5. Compile the smart contracts:
   ```bash
   yarn hardhat compile
   ```

## Usage

1. Run the local development network:
   ```bash
   yarn hardhat node
   ```

2. Deploy the smart contracts to the local network:
   ```bash
   yarn hardhat run scripts/deployNft.js --network localhost
   yarn hardhat run scripts/deployDao.js --network localhost
   ```
3. Interact with the smart contracts using the Hardhat console or integrate them into your DApp.
   
    

## Contribution
Contributions to this project are welcome. To contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch.
3. Make your changes and commit them.
4. Push your changes to your fork.
5. Submit a pull request.
6. Please ensure your code follows the existing code style and includes appropriate tests.

## License
This project is licensed under the [MIT License]().

## Deployed to

- Collegence.sol  
  Address: [0x1811E1c046650856A8bf7dd34233e665Cb17f529](https://mumbai.polygonscan.com/address/0x1811E1c046650856A8bf7dd34233e665Cb17f529#code)
  Network: Polygon Mumbai

- DAO.sol  
  [0xA999902839803Fe3dc70A5e0Fd7086CeaE6902f5](https://mumbai.polygonscan.com/address/0xA999902839803Fe3dc70A5e0Fd7086CeaE6902f5#code)  
    Network: Polygon Mumbai
