require("pry")
require("./models/property_search")



property1 = Property.new({
  'address' => "9 Hollybank Cres",
  'value' => 100000,
  'number_of_bedrooms' => 3,
  'buy_let_status' => "sale"
  })

property1.save()

property2 = Property.new({
  'address' => "15 Ivy Lane",
  'value' => 120000,
  'number_of_bedrooms' => 3,
  'buy_let_status' => "sale"
    })

property2.save()

# property1.delete()

property1.value = 130000
property1.update()

#how to ask it to run 'find' using only an ID
found = Property.find_by_id(property1.id)

found_by_address = Property.find_by_address("15 Ivy Lane")

all_houses = Property.all

Property.delete_all

binding.pry
nil
