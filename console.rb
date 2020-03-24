require('pry-byebug')

require_relative('models/property.rb')

property1 = Property.new({'address' => '0/3 190 Clouston Street',
                          'value' => 5_000_000,
                          'number_of_bedrooms' => 3,
                          'buy_let_status' => 'available to buy'

  })

property2 = Property.new({'address' => '3/1 44 Hillhead Street',
                          'value' => 10_000_000,
                          'number_of_bedrooms' => 6,
                          'buy_let_status' => 'sold'
          })


property1.save
property2.save

found_property = Property.find(12)

found_property_by_address = Property.find_by_address('3/1 44 Hillhead Street')

binding.pry
nil
