

class ContractBase

  class << self
    attr_accessor :state_variable_definitions, 
                  :parent_contracts, 
                  :events, 
                  :is_abstract_contract
  end

  def self.pragma(*args)
    # Do nothing for now
  end
  
##################
# parent contracts  
  def self.abstract
    @is_abstract_contract = true
  end
  

  def self.linearize_contracts( contract )
   ## for now 
    ##    include all classes before ContractImplementation
    ##    cache result - why? why not?

    ##
    ## todo/fix: check if include? ContractImplementation
    ##                    if not raise error - CANNOT linearize (no contract base found)
    classes = []
    contract.ancestors.each do |ancestor|
        break if ancestor == ContractImplementation ||
                 ancestor == ContractBase
        if ancestor.instance_of?( Class )
            classes << ancestor 
        else  ### assume Module
            puts "[debug] skipping module - #{ancestor.name} : #{ancestor.class.name}"
        end
    end    
    classes
  end

  def self.linearized_parents
    ## note: exclude self (that is, cut-off first class)
    linearize_contracts( self )[1..-1]
  end


 ####
 # events
 def self.event( name, args )
    @events ||= {}
    name = name.to_sym  ## note: make sure name is ALWAYS a symbol
    @events[name] = args
  end

  def self.events
    @events || {}
  end



########
# state variables
  def self.state_variable_definitions
    @state_variable_definitions ||= {}
  end


  def self.define_state_variable(type, args)
    ## note: REMOVE last item from array (use Array#pop)
    ##  make sure name is ALWAYS a symbol!!!
    name = args.pop.to_sym
    
    if state_variable_definitions[name]
      raise "No shadowing: #{name} is already defined."
    end

    ## check for visibility  - internal/private/public
    visibility = :internal    ## make :public default - why? why not?
    immutable  = false
    constant   = false

    ##  todo/check - force strict check for double (public/private etc.) use - why? why not?
    args.each do |arg|
      case arg
      when :public, :private, :internal then  visibility = arg
      when :immutable                   then  immutable = true
      when :constant                    then  constant = true
      else
         raise ArgumentError, "unknown type qualifier >#{arg}<; sorry for typedef #{type} in #{args.inspect}" 
      end
    end
    
    state_variable_definitions[name] = { type: type, 
                                         visibility: visibility,
                                         immutable: immutable,
                                         constant: constant }
    
  
    ## check - visibility 
    if visibility == :public
       create_public_getter_function( name, type, constant: constant,
                                                  immutable: immutable )
    end
    
    type
  end


  Type.value_types.each do |type|
    define_singleton_method(type) do |*args|
      type = Type.create( type )
      define_state_variable(type, args)
    end
  end
  
  def self.mapping(*args)
    # note: REMOVE first item from array (use Array#shift)
    key_type, value_type = args.shift.first
    type = Type.create( :mapping, key_type: key_type, 
                                  value_type: value_type )
    
    if args.last.is_a?(Symbol)
      define_state_variable(type, args)
    else
      type
    end
  end
  
  def self.array(*args)
    # note: REMOVE first item from array (use Array#shift)
    sub_type = args.shift
    type = Type.create(:array, sub_type: sub_type )
    
    define_state_variable(type, args)
  end


####
#  functions / abis

def self.abi
    @abi ||= AbiProxy.new(self)
end

def self.public_abi
    abi.select do |name, details|
      details.publicly_callable?
    end
end
def public_abi() self.class.public_abi; end
  


def self.sig( name, args=[], *options, returns: nil )
  puts "[debug] add sig #{name} args: #{args.inspect}, options: #{options.inspect}, returns: #{returns.inspect}"
  @sigs ||= {}
  name = name.to_sym  ## note: make sure name is ALWAYS a symbol
  ## use inputs for args) and outputs for returns  - why? why not?
  @sigs[name] = { inputs:  args,
                  outputs: returns,
                  options: options }
end

def self.sigs
  @sigs || {}
end



def self.function( name, args, *options, returns: nil, &block)
    abi.create_and_add_function(name, args, *options, returns: returns, &block)
end
  
def self.constructor(args = {}, *options, &block)
    function(:constructor, args, *options, returns: nil, &block)
end


###
#  add public getters helpers
  def self.create_public_getter_function(  name, type, constant: false,
                                                       immutable: false )
    
    if type.mapping?
      create_mapping_getter_function( name, type, constant: constant,
                                                  immutable: immutable )
    elsif type.array?
        puts "[debug] auto-generate public array getter - #{name} : #{type}:"
        function( name, {index: :uint256},
                       :public, :view, returns: type.sub_type.name) do
          puts "[debug] call public (state) array getter for #{name} : #{type} with index #{send(:index)}"
          puts "[debug]  self -> #{self}"
          puts "[debug]  self.this -> #{this}"
          value = this.instance_variable_get( "@#{name}" )
          value[send(:index)]    ## check if value[index] works???
      end
    else
      puts "[debug] auto-generate public getter - #{name} : #{type}:"
      function( name, {}, 
                       :public, :view, returns: type.name) do
          puts "[debug] call public (state) getter for #{name} : #{type}"
          puts "[debug]  self -> #{self}"
          puts "[debug]  self.this -> #{this}"
          value = this.instance_variable_get( "@#{name}" )
          value
       end
    end
  end
  

  def self.create_mapping_getter_function( name, type, constant: false,
                                                       immutable: false)
    arguments = {}
    index = 0
    current_type = type

    while current_type.name == :mapping
      arguments["arg#{index}".to_sym] = current_type.key_type.name
      current_type = current_type.value_type
      index += 1
    end
    
    puts "[debug] auto-generate public mapping getter - #{name} : #{type}:"
    puts "    arguments:"
    pp   arguments
    puts "    index: #{index}"
# {:arg0=>:addressOrDumbContract}
#    index: 1

    function( name, arguments, :public, :view, returns: current_type.name) do
        puts "[debug] call public (state) mapping getter for #{name} : #{type}"
        puts "[debug]  self -> #{self}"
        puts "[debug]  self.this -> #{this}"
        value = this.instance_variable_get( "@#{name}" )
        (0...index).each do |i|
          value = value[send("arg#{i}".to_sym)]
        end
        value
    end
  end
end  # classContractBase

