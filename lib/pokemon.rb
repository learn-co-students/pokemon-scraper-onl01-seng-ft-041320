class Pokemon
    attr_accessor :name, :type, :db, :id

    def initialize(attr_hash)
      attr_hash.each do |k, v|
        self.send("#{k}=", v)
      end 
    end

    def self.save(name, type, db)
      attr_hash = {:name => name, :type => type, :db => db}
      pokemon = self.new(attr_hash)
      sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (
            ?,
            ?
        )
        SQL
      pokemon.db.execute(sql, pokemon.name, pokemon.type)
      pokemon.id = pokemon.db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
      pokemon
    end

    def self.find(id, db)
      sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL
      pokemon_attr = db.execute(sql,id)
      #binding.pry
      attr_hash = {:name => pokemon_attr[0][1], :type => pokemon_attr[0][2], :db => db}
      pokemon = Pokemon.new(attr_hash)
      pokemon.id = pokemon_attr[0][0]
      pokemon
    end
end
