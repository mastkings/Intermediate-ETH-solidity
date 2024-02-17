// imports
const hre = require("hardhat");
const fs = require('fs');

// function to deploy the contracts
async function main() {

  //deploy the token
  const Master = await hre.ethers.getContractFactory("MasterToken");
  const master = await Master.deploy();
  await master.deployed();
  console.log("master deployed to:", master.address);


  // export the addresses
  fs.writeFileSync('src/abi/address.js', `
    export const masterAddress = "${master.address}"

  `)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
