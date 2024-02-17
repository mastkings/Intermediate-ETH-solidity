const { expect } = require("chai");

describe("ErrorHandling Contract", function () {

  let ErrorHandling;
  let errorHandling;
  let owner;
  let addr1;

  beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    ErrorHandling = await ethers.getContractFactory("ErrorHandling");
    [owner, addr1] = await ethers.getSigners();

    // To deploy our contract, we just call ErrorHandling.deploy() and await for it to be deployed(), which happens once its transaction has been mined.
    errorHandling = await ErrorHandling.deploy();
    await errorHandling.deployed();
  });

  // Test case for deposit function
  describe("Deposit", function () {
    it("Should deposit the correct amount", async function () {
      const depositAmount = ethers.utils.parseEther("1.0"); // 1 ether
      await errorHandling.connect(owner).deposit(depositAmount);
      expect(await errorHandling.contractBalance()).to.equal(depositAmount);
    });

    it("Should fail with zero deposit", async function () {
      await expect(errorHandling.connect(owner).deposit(0)).to.be.revertedWith("ZeroAmountError");
    });
  });

  // Additional test cases for withdraw, divide, etc. can be similarly structured.
});
