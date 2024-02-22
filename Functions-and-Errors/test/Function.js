const { expect } = require("chai");

describe("AccountManager", function () {
  let accountManager;
  let owner;
  let addr1;

  beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    const AccountManager = await ethers.getContractFactory("AccountManager");
    [owner, addr1] = await ethers.getSigners();

    // Deploy a new AccountManager contract before each test.
    accountManager = await AccountManager.deploy();
    await accountManager.deployed();
  });

  describe("Transactions", function () {
    it("Should deposit funds correctly", async function () {
      await accountManager.depositRequire(100);
      expect(await accountManager.totalFunds()).to.equal(100);
    });

    it("Should fail deposit with 0 or negative amount", async function () {
      await expect(accountManager.depositRequire(0)).to.be.revertedWith("Deposit must be a positive value.");
    });

    it("Should withdraw funds correctly", async function () {
      await accountManager.depositRequire(100);
      await accountManager.withdrawRequire(50);
      expect(await accountManager.totalFunds()).to.equal(50);
    });

    it("Should fail withdrawal with insufficient funds", async function () {
      await accountManager.depositRequire(50);
      await expect(accountManager.withdrawRequire(100)).to.be.revertedWith("Not enough funds for this withdrawal.");
    });

    it("Should perform division correctly", async function () {
      expect(await accountManager.divideRequire(100, 4)).to.equal(25);
    });

    it("Should revert division by zero", async function () {
      await expect(accountManager.divideRequire(100, 0)).to.be.revertedWith("Denominator cannot be zero value.");
    });

    it("Should not revert in assertFunction", async function () {
      // This test assumes the assert in assertFunction will not fail.
      // Update the expected condition if the assertFunction logic changes.
      await expect(accountManager.assertFunction()).not.to.be.reverted;
    });

    it("Should revert in revertFunction if condition is not met", async function () {
      // Assuming the logic in revertFunction is to revert if the result is not 25.
      await expect(accountManager.revertFunction()).to.be.revertedWith("Result is not as expected.");
    });
  });
});
