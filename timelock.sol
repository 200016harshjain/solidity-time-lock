pragma solidity ^0.8.0;

//using safe math 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "hardhat/console.sol";
contract TimeLock {
 /*
    Functions to implement
     //deposit
    //withdraw
    //increase timelock
    //view time left
*/

/*
    need to store balance per user and time per user

*/
using SafeMath for uint;

mapping(address => uint) public balancePerUser;
mapping(address => uint) public timeLeftPerUser;

function deposit( uint amount) external payable {

    balancePerUser[msg.sender] = balancePerUser[msg.sender].add(amount);
  timeLeftPerUser[msg.sender] =  timeLeftPerUser[msg.sender] + block.timestamp + 20 seconds;   



}
function increaseTimeLock( uint timeInSeconds) public {
    timeLeftPerUser[msg.sender] = timeLeftPerUser[msg.sender].add(timeInSeconds);
}

function viewTimeLeft() public view returns (uint256) {
    return timeLeftPerUser[msg.sender].sub(block.timestamp);
}

function checkBalance() public view returns (uint) {
    return balancePerUser[msg.sender];
}

function withdraw() external payable {
    require(balancePerUser[msg.sender] >0 , "Insufficient funds" );
        if(block.timestamp > timeLeftPerUser[msg.sender])
    {
        uint amount = balancePerUser[msg.sender];
        balancePerUser[msg.sender] = 0;
         (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send ether");
    }
}







}
