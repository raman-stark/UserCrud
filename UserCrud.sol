// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract UserCrud{
    struct userStruct{
        uint userAge;
        uint index;
        string userName;
        string userEmail;
    }
    
    mapping(address => userStruct) private userStructs;
    address[] private userIndex;
    
    event LogNewUser(
        address indexed userAddress,
        uint index,
        uint userAge,
        string userName,
        string userEmail);
        
    event LogUpdateUser(
        address indexed userAddress,
        uint index,
        uint userAge,
        string userName,
        string userEmail);
        
    function isUser(address userAddress) public view returns (bool isIndeed) {
        if (userIndex.length == 0) return false;
        return (userIndex[userStructs[userAddress].index] == userAddress);
    }
    
    function insertUser(
        address userAddress,
        uint userAge,
        string memory userName,
        string memory userEmail) public payable returns (uint index) {
            // if (isUser(userAddress)) throw;
            require(!isUser(userAddress), "User already exist");
            userStructs[userAddress].userAge = userAge;
            userStructs[userAddress].userName = userName;
            userStructs[userAddress].userEmail = userEmail;
            // userStructs[userAddress].index = userIndex.push(userAddress) - 1;
            userIndex.push(userAddress);
            userStructs[userAddress].index = userIndex.length - 1;
    }
    
    function getUser(address userAddress) public view returns(
        uint index,
        uint userAge,
        string memory userEmail,
        string memory userName) {
            // if(!isUser(userAddress)) throw;
            require(isUser(userAddress));
            return(
                userStructs[userAddress].index,
                userStructs[userAddress].userAge,
                userStructs[userAddress].userEmail,
                userStructs[userAddress].userName);
    }
    
    function updateUserName(
        address userAddress,
        string memory userName) public returns(bool success) {
            // if (!isUser(userAddress)) throw;
            require(isUser(userAddress));
            userStructs[userAddress].userName = userName;
            emit LogUpdateUser(
                userAddress,
                userStructs[userAddress].index,
                userStructs[userAddress].userAge,
                userStructs[userAddress].userEmail,
                userName);
            return true;
    }
    
    function updateUserEmail(
        address userAddress,
        string memory userEmail) public returns(bool success) {
            // if (!isUser(userAddress)) throw;
            require(isUser(userAddress));
            userStructs[userAddress].userEmail = userEmail;
            emit LogUpdateUser(
                userAddress, 
                userStructs[userAddress].index,
                userStructs[userAddress].userAge,
                userEmail, 
                userStructs[userAddress].userName);
            return true;
    }
        
    function UpdateUserAge(
        address userAddress,
        uint userAge) public returns(bool success) {
            // if (!isUser(userAddress)) throw;
            require(isUser(userAddress));
            userStructs[userAddress].userAge = userAge;
            emit LogUpdateUser(
                userAddress, 
                userStructs[userAddress].index,
                userAge,
                userStructs[userAddress].userEmail, 
                userStructs[userAddress].userName);
            return true;
    }
    
    function getUserCount() public view returns (uint count) {
        return userIndex.length;
    }
    
    function getUserAtIndex(uint index) public view returns(
        address userAddress) {
            return userIndex[index];
    }
}
