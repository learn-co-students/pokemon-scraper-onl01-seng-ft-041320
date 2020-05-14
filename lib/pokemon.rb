class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id: nil, name:, type:, db:)
        @id= id
        @name= name
        @type= type
        @db= db
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
          SELECT * FROM pokemon
          WHERE id = ?
          SQL
        pokemon_attr = db.execute(sql,id)
        attr_hash = {:name => pokemon_attr[0][1], :type => pokemon_attr[0][2], :db => db}
        pokemon = Pokemon.new(attr_hash)
        pokemon.id= pokemon_attr[0][0]
        pokemon
      end


end
