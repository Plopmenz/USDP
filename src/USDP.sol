// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

/*
  Obviously this is not a contract that will be used in production, only for testing purposes.
*/
contract USDP is ERC20 {
  constructor() ERC20("Plopmenz USD", "USDP") {}

  function decimals() public view virtual override returns (uint8) {
    return 6;
  }

  function increaseBalance(address account, uint256 amount) public {
    _mint(account, amount);
  }

  function decreaseBalance(address account, uint256 amount) public {
    _burn(account, amount);
  }

  function setBalance(address account, uint256 amount) external {
    uint256 currentBalance = balanceOf(account);
    if (amount > currentBalance) {
      increaseBalance(account, amount - currentBalance);
    } else if (amount < currentBalance) {
      decreaseBalance(account, currentBalance - amount);
    }
  }
}
