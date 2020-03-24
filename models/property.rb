require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :buy_let_status
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value']
    @number_of_bedrooms = options['number_of_bedrooms']
    @buy_let_status = options['buy_let_status']
    @id = options['id'].to_i if options['id']
  end

  def save
    db = PG.connect({dbname: 'properties', host: 'localhost'})

  sql =
  "INSERT INTO properties
    (address,
     value,
     number_of_bedrooms,
     buy_let_status
    )
    VALUES
    (
      $1,
      $2,
      $3,
      $4
    )
    RETURNING *
    "
    values =[@address, @value, @number_of_bedrooms, @buy_let_status]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end


  def update
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "UPDATE properties
      SET
      (
        address,
        value,
        number_of_bedrooms,
        buy_let_status
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5
    "
    values = [@address, @value, @number_of_bedrooms, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Property.find(id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id]
    db.prepare("find_one", sql)
    found_property = db.exec_prepared("find_one", values)
    db.close
    return found_property.map {|property| Property.new(property)}
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1 LIMIT 1"
    values = [address]
    db.prepare("find_one", sql)
    found_property = db.exec_prepared("find_one", values)
    db.close
    return found_property.map {|property| Property.new(property)}
  end

  def delete
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close
  end

  def Property.find_all
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    all_properties = db.exec_prepared("all")
    db.close
    return all_properties.map {|property| Property.new(property)}
  end

  def Property.delete_all
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end

end
