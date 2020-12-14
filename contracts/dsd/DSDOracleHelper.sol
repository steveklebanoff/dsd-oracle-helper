pragma solidity ^0.5.17;
pragma experimental ABIEncoderV2;

import "./external/UniswapV2OracleLibrary.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "./external/Decimal.sol";

contract DSDOracleHelper {
    address private constant UNISWAP_FACTORY = address(
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f
    );
    address private constant USDC = address(
        0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
    );

    using Decimal for Decimal.D256;

    function getPrice(
        address dollar,
        uint256 _index,
        uint32 _timestamp,
        uint256 _cumulative
    ) public returns (uint256 value) {
        IUniswapV2Pair _pair = IUniswapV2Pair(
            IUniswapV2Factory(UNISWAP_FACTORY).createPair(dollar, USDC)
        );
        (
            uint256 price0Cumulative,
            uint256 price1Cumulative,
            uint32 blockTimestamp
        ) = UniswapV2OracleLibrary.currentCumulativePrices(address(_pair));
        uint32 timeElapsed = blockTimestamp - _timestamp; // overflow is desired
        uint256 priceCumulative = _index == 0
            ? price0Cumulative
            : price1Cumulative;
        Decimal.D256 memory price = Decimal.ratio(
            (priceCumulative - _cumulative) / timeElapsed,
            2**112
        );

        _timestamp = blockTimestamp;
        _cumulative = priceCumulative;

        return price.mul(1e12).value;
    }
}
