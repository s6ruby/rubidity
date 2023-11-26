#####
#  build  sub1k.db  (sqlite database with first thousand ethscriptions)

$LOAD_PATH.unshift( "../scribelite/lib" )
require 'scribelite'



ScribeDb.open( './sub1k.db' )


puts
puts "  #{Scribe.count} scribe(s)"
puts "  #{Tx.count} tx(s)"
#=>   0 scribe(s)
#=>   0 tx(s)


# page size = 25,  25*40 = 1000 ethscriptions

(1..40).each do |page|
    ScribeDb.import_ethscriptions( page: page )
end

puts
puts "  #{Scribe.count} scribe(s)"
puts "  #{Tx.count} tx(s)"
#=>   1000 scribe(s)
#=>   1000 tx(s)


puts "bye"