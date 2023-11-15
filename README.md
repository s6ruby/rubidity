
**DISCLAIMER:   the rubidity gem version is different 
from the rubidity built into the facet vm / app and i (Gerald Bauer) 
am NOT affiliated with facet computing inc. (middlemarch et al) or paid to work on the rubidity gem.**



# Rubidity  -  Ruby for Layer 1 (L1) Contracts / Protocols with "Off-Chain" Indexer


## What's Happening Here?

This is a rubidity sandbox by [Gerald Bauer](https://github.com/geraldb)

The idea here is to experiment with rubidity "off-chain"
and if time permits break the "majestic rails rubidity monolith"
also known as "facet vm" (formerly "ethscriptions vm") up into easier to (re)use modules.

For example, why not bundle up a "core" language "rubidity" gem with 
no dependencies on any blockchain and break out "core / standard" 
contracts samples and database (SQL) and runtime modules or such.



The first published modules / gems include:

- [~~**rubidity-typed**~~](rubidity-typed) - "zero-dependency" 100%-solidity compatible data type machinery incl. (frozen) string, address, uint, int, enum, struct, array, mapping, and more for rubidity - ruby for layer 1 (l1) contracts / protocols with "off-chain" indexer

- [**solidity-typed**](solidity-typed) (formerly known as rubidity-typed) -  "zero-dependency" 100%-solidity compatible data type and application binary interface (abi) machinery incl. bool, (frozen) string, address, bytes, uint, int, enum, struct, array, mapping, event, and more for solidity-inspired contract (blockchain) programming languages incl. rubidity et al



- [**rubidity**](rubidity) - ruby for layer 1 (l1) contracts / protocols with "off-chain" indexer 

- [**rubidity-contracts**](rubidity-contracts) - standard contracts (incl. erc20, erc721, etc) for ruby for layer 1 (l1) with "off-chain" indexer

- [**uniswap**](uniswap) - core uniswap v2 (dumb) contracts for ruby (rubidity) for layer 1 (l1) with "off-chain" indexer

- [**programming-uniswap**](programming-uniswap) - programming (decentralized finance - defi) uniswap v2 contracts article series, the ruby / rubidity edition
  - [Programming DeFi: Uniswap V2. Part 1](programming-uniswap/part1)
  - [Programming DeFi: Uniswap V2. Part 2](programming-uniswap/part2)


- [**rubidity-classic**](rubidity-classic) - rubidity classic / o.g. contract builder; trying the impossible and square the circle, that is, a rubidity "classic / o.g." dsl builder generating rubidity "more ruby-ish" contract classes. 




More:

- [~~**rubidity-simulacrum**~~](rubidity-simulacrum) - run (dumb) blockchain contracts in rubidity (with 100%-solidity compatible data types & abis) on an ethereum simulacrum in your own home for fun & profit (for free)

- [~~**redpaper**~~](redpaper) - Yes, you can. it's just ruby. Run the sample contracts from the [Red Paper](https://github.com/s6ruby/redpaper)
with rubidity and simulacrum!


- [**soliscript**](https://github.com/soliscript/soliscript) (formerly known as rubidity-simulacrum) - run blockchain contracts in rubidity (with 100%-solidity compatible data types & abis) on an ethereum simulacrum in your own home for fun & profit (for free)

- [**soliscript.starter**](https://github.com/soliscript/soliscript.starter) (formerly known as red paper contracts) -  run (blockchain) contracts in rubidity (with 100%-solidity compatible data types & abis) on an ethereum simulacrum in your own home for fun & profit (for free) incl. the red paper contracts e.g. satoshi dice (gambling), crowd funder, ballot (liquid delegate democracy)



- [**rubidity-by-example**](rubidity-by-example) - Rubidity By Example - an introduction to Rubidity with simple examples (inspired and mostly following Solidity By Example)

- [**learninminutes**](learninminutes) - Learn X in Y Minutes (Where X=Rubidity, Y=?)




For some ongoing (or historic) 
rubidity discussions & comments from 
the discord (chat server), see the [Changelog  - Good Morning](CHANGELOG.md).





## Bonus - More Blockchain (Crypto) Tools, Libraries & Scripts In Ruby

See [**/blockchain**](https://github.com/rubycocos/blockchain) 
at the ruby code commons (rubycocos) org.





## Questions? Comments?

Join us in the [Rubidity (community) discord (chat server)](https://discord.gg/3JRnDUap6y). Yes you can.
Your questions and commentary welcome.

Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.

