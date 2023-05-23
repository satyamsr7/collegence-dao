const hre = require("hardhat");

async function main() {
    const Collegence = await hre.ethers.getContractFactory("Collegence");
    const collegence = await Collegence.deploy();

    await collegence.deployed();

    console.log(
        `Collegence deployed to ${collegence.address}`
    );
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
