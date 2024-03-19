// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

//The contract allows only its creator to create new coins (different issuance schemas are possible)
// Anyone can send coins to each other without a need for registering with a username and password

contract Coin {
    //the keyword public its making the variables
    //here accessible from other contracts
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);
    // constructor only runs when we deploy contract
    constructor() {
        minter = msg.sender;

    }

    // make new coins and send them to an adderess
    // only the owner can send these coins 

    function mint(address reciever, uint amount ) public {
    require(msg.sender == minter);
    balances[reciever] += amount;
    }
 
    // send any amount of coins
    // to an existing address


    error insufficientBalance(uint requested, uint available);

    function send(address reciever, uint amount) public {  
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
    }

  
}