const { expect } = require("chai");
const {ethers} = require("hardhat");

describe("MasterToken", function () {
  let Master;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();

    const masterContract = await ethers.getContractFactory("MasterToken");
    Master = await masterContract.deploy();

    // Mint some tokens to the contract creator
    await Master.mint(owner.address, 6);
  });

  it("Should return the correct name, symbol, and total supply", async function () {
    expect(await Master.name()).to.equal("Eth MasterToken");
    expect(await Master.symbol()).to.equal("MTT");
    expect(await Master.totalSupply()).to.equal(12);
  });

  it("Should update balances after minting and burning tokens", async function () {
    // Mint some tokens to address 1
    await Master.connect(owner).mint(addr1.address, 2);

    expect(await Master.balances(addr1.address)).to.equal(2);
    expect(await Master.totalSupply()).to.equal(14);

    // Burn some tokens from the contract creator
    await Master.connect(owner).burn(3);

    expect(await Master.balances(owner.address)).to.equal(9);
    expect(await Master.totalSupply()).to.equal(11);
  });

  it("Should revert if an invalid address is provided to mint", async function () {
    await expect(Master.connect(owner).mint("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", 1)).to.be.revertedWith("Invalid address");
  });

  it("Should revert if the contract creator doesn't have sufficient balance to burn", async function () {
    await expect(Master.connect(owner).burn(16)).to.be.revertedWith("Insufficient balance");
  });
});
