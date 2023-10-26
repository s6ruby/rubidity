pragma :rubidity, "1.0.0"

import './ERC20'

contract :PublicMintERC20, is: :ERC20 do
  uint256 :public, :maxSupply
  uint256 :public, :perMintLimit
  
  constructor(
    name: :string,
    symbol: :string,
    maxSupply: :uint256,
    perMintLimit: :uint256,
    decimals: :uint8
  ) do |name, symbol, maxSupply, perMintLimit, decimals|
    ## note: super not working e.g.
    ## -  TypeError - self has wrong type to call super in this context:
    ##                    PublicMintERC20 (expected #<Class:Builder>) 
    ## super( name: name, symbol: symbol, decimals: decimals )
    ## was: ERC20.constructor
    __ERC20__constructor( name: name, symbol: symbol, decimals: decimals )
    @maxSupply = maxSupply
    @perMintLimit = perMintLimit
  end
  
  
  function :mint, { amount: :uint256 }, :public do |amount|
    require(amount > 0, 'Amount must be positive')
    require(amount <= s.perMintLimit, 'Exceeded mint limit')
    
    require(s.totalSupply + amount <= s.maxSupply, 'Exceeded max supply')
    
    _mint(to: msg.sender, amount: amount)
  end
  
  function :airdrop, { to: :address, amount: :uint256 }, :public do |to, amount|
    require(amount > 0, 'Amount must be positive')
    require(amount <= s.perMintLimit, 'Exceeded mint limit')
    
    require(s.totalSupply + amount <= s.maxSupply, 'Exceeded max supply')
    
    _mint(to: to, amount: amount)
  end
end
