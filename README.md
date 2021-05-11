# Superfluid-ERC20-Wrapping
Creating a custom ERC20 token (named "testMaker") and making a wrapped version of it as a streamable Superfluid Super Token. These steps can be appropriated for any ERC20 token!

### Implementation

1. Switch to a testnet

2. Deploy testMaker token (or use pre-deployed)
    * Deploy testMaker contract in testMaker.sol, set initial supply

3. Deploy Wrapped Super Token Contract
    * Deploy initMakerSuperToken contract in init.sol
    * Run *createMakerSuperToken* function with address of testMaker token contract as argument
    * Run *getSuperToken* function with address of testMaker token contract as argument
        * This will provide the address of the Wrapped Super Token Contract on the testnet. Copy it!

4. Create Super Token
    * Load contract at address recieved from *getSuperToken* function with ISuperToken ABI - @superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol *(see Remix example below)*
    
    ![Loading Wrapped Super Token Contract](./img/loadWrappedSuperTokenContract.jpg)

    * Use *upgrade* function to create Super Token with supply of zero
        * *Note* You can do a gut check by using the *symbol* function and see if it returns "MKRtx"

    ![Upgrade Wrapped Super Token Contract to Super Token](./img/upgrade.jpg)

5. Add to MetaMask
    * If using MetaMask, you can use the address of the Super Token Contract to add the token

    ![Add to MetaMask](./img/addmetamask.jpg)
