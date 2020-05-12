class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize (id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def Pokemon.save (name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
        id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
        new_pokemon = Pokemon.new(id: id, name: name, type: type, db: db)
    end

    def Pokemon.find (id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL
 
        data = db.execute(sql, id)[0]
        name = data[1]
        type = data[2]
        Pokemon.new(id:id, name:name, type:type, db:db)
    end
end
