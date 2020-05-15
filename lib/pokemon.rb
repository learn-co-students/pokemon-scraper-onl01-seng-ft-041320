require 'pry'
class Pokemon
  attr_accessor :db, :id, :name, :type

  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
  end

  def self.new_from_db(row)
    pokemon = self.new(row[0], row[1], row[2], row[3])
    pokemon
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL

    pokemon = db.execute(sql, id)[0]
    pokemon = self.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: pokemon[3])
  end
end
