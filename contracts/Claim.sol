// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import '@pancakeswap/pancake-swap-lib/contracts/token/BEP20/SafeBEP20.sol';
import '@pancakeswap/pancake-swap-lib/contracts/access/Ownable.sol';
import "./ILP.sol";
import "./IController.sol";

contract Claim is Ownable {

    IController public controller;
    uint256 public _tokens;
    mapping(address => uint) public startTime;
    uint public lockTime = 300 seconds;

    constructor(IController _controller) public {
        controller = _controller;
    }

    function setTokensForClaim(uint256 _value) external onlyOwner {
        _tokens = _value;
    }

    function setLockTime(uint _value) external onlyOwner {
        lockTime = _value;
    }    

    function pending(ILP _pool) external view returns (uint256) {
        return _pool.pendingCake();
    }

    function claim(ILP _pool) external {
        require(block.timestamp > startTime[address(_pool)] + lockTime, 'too early');
        if(_pool.pendingCake() > 0){
            _pool.claim();
            controller.mint(msg.sender, _tokens);
            startTime[address(_pool)] = block.timestamp;
        }
    }

}
