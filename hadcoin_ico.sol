
pragma solidity ^0.4.11;

contract hadcoin_ico {
    // Introducing the maximum number of hadcoin available for sale
    uint public max_hadcoins = 1000000;
    // Introducing the USD to hadcoin conversion
    uint public  usd_to_hadcoins = 1000;
    // Introducing the total hadcoins bought by investors
    uint public total_hadcoins_bought = 0 ;
    // Maping the from the investors address to its equity in Hadcoins and USD
    mapping(address => uint) equity_hadcoins;
    mapping(address => uint) equity_USD;

    // check if investor can buy hadcoins
    modifier can_buy_hadcoin(uint usd_invested){
        require(usd_invested * usd_to_hadcoins + total_hadcoins_bought <= max_hadcoins);
        _;


    }

    // Getting equity in Hadcoin of an investor
    function equity_in_hadcoin(address investor) external constant returns (uint) {
        return equity_hadcoins[investor];
    }
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_USD[investor];
    }

    // Buying Hadcoins
    function buy_hadcoin(address investor, uint usd_invested) external 
    can_buy_hadcoin(usd_invested){
        uint hadcoin_bought = usd_invested * usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoin_bought;
        equity_USD[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought += hadcoin_bought;
    }
    // Selling Hadcoins
    function sell_hadcoin(address investor, uint hadcoin_sold) external {
        equity_hadcoins[investor] -= hadcoin_sold;
        equity_USD[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought -= hadcoin_sold;
    }


}




