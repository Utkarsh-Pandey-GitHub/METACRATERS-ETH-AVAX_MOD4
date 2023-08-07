// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Degen is  ERC20{
    address public owner;
    constructor(uint256 initialSupply) ERC20("Degen","DGN"){
        owner=msg.sender;
        _mint(msg.sender,initialSupply);// send thse amount of tokens to the owner of the contract
    }

    modifier onlyOwner(){
        if (msg.sender!=owner){
            revert("sender is not owner, unauthorized");
        }
        _;
    }
    modifier checkBalance(uint256 amount){
        if(balanceOf(msg.sender)<amount){
            revert("insuficient funds");
        }
        _;
    }
    function reward(uint256 amount,address toPlayer)public onlyOwner(){
        approve(toPlayer,amount);
    }

    function transferToken(uint256 amount,address toPlayer)public{
        transfer(toPlayer,amount);
    }

    function redeem(uint256 amount)public{
        if(amount>allowance(owner,msg.sender)){
            revert("request amount is more than the rewards");
        }
        transferFrom(owner,msg.sender,amount);
    }

    function balance()public view returns (uint256){
        return balanceOf(msg.sender);
    }

    function burnToken(uint256 amount)public checkBalance(amount){
        
        _burn(msg.sender,amount);
    }
}
