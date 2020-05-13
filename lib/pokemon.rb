class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(name:, type:, db:, id:nil)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name, type, database_connection)
        database_connection.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    def self.find(id, database_connection)
        pokemon = database_connection.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
        name = pokemon[1]
        type = pokemon[2]

        new_pokemon = self.new(id: id, name: name, type: type, db: database_connection)
    end
end
