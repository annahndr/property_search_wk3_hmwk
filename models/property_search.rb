require("pg")


class Property

  attr_accessor :address, :value, :number_of_bedrooms, :buy_let_status
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @address = options["address"]
    @value = options["value"].to_i
    @number_of_bedrooms = options["number_of_bedrooms"].to_i
    @buy_let_status = options ["buy_let_status"]
  end


  def save()
      #open a connection to the database
      #the server we;re interested in is this machine
      #database name is what we created in terminal
    db = PG.connect({ dbname: "properties", host: "localhost"})
      #now create the commands you need in sql as a string
    sql = "INSERT INTO property_search
    (address, value, number_of_bedrooms, buy_let_status)
    VALUES ($1, $2, $3, $4)
    RETURNING *"
      #doing it this (with the $ placeholders) way makes you less vulnerable
    values = [@address, @value, @number_of_bedrooms, @buy_let_status]


    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i

    db.close()
  end

  def delete()
    db = PG.connect ({dbname: "properties", host: "localhost"})

    sql = "DELETE FROM property_search WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close
  end

  def update()
    db = PG.connect ({dbname: "properties", host: "localhost"})

    sql = "UPDATE property_search SET (address, value, number_of_bedrooms, buy_let_status) = ($1, $2, $3, $4) WHERE id =$5"

    values = [@address, @value, @number_of_bedrooms, @buy_let_status, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Property.find_by_id(id)
    db = PG.connect ({dbname: "properties", host: "localhost"})

    sql = "SELECT * FROM property_search WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
  properties = db.exec_prepared("find_by_id", values)
    db.close
    found_property_hash = properties[0]
    return Property.new(found_property_hash)
  end


  def Property.find_by_address(address)
    db = PG.connect ({dbname: "properties", host: "localhost"})
    sql = "SELECT * FROM property_search WHERE address = $1"
    values = [address]
    db.prepare("find_by_address", sql)
    properties = db.exec_prepared("find_by_address", values)
    db.close
    found_property_hash = properties[0]
    return Property.new(found_property_hash)
  end



  def Property.all()
    db = PG.connect ({dbname: "properties", host: "localhost"})
    sql = "SELECT * FROM property_search"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    #returns an array of hashes (called properties)
    db.close
    return properties.map{|property_hash| Property.new(property_hash)}
    #this transforms the hashes into an array of objects??
  end


  def Property.delete_all()
    db = PG.connect ({dbname: "properties", host: "localhost"})
    sql = "DELETE FROM property_search"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end






##
end
