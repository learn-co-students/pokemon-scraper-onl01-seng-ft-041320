class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        if find_by_name(name, db) == []
            update
        else
            sql = "INSERT INTO pokemon (name, type)
                    VALUES (?, ?)"

            db.execute(sql, name, type)

            db.execute("SELECT last_insert_rowid() FROM pokemon")
        end
    end

    def self.all
        @@all = @db.execute("SELECT * FROM pokemon")
    end

    def self.find(id, db)
        sql = "SELECT * FROM pokemon
            WHERE id == ?"
        new_from_row(db.execute(sql, id)[0], db)
    end

    def self.find_by_name(name, db)
        sql = "SELECT * FROM pokemon
            WHERE name == ?"

        result = db.execute(sql, name)
        result == [] ? nil : new_from_row(db.execute(sql, name), db)
    end

    def self.new_from_row(row, db)
        new_pokemon = self.new(id: row[0], name: row[1], type: row[2], db: db)
    end

end
