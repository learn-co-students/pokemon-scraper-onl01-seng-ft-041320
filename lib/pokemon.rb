class Pokemon
    attr_accessor :id, :name, :type, :db
    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
      end
     
    #saves an instance of a pokemon with the correct id
    def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    #finds a pokemon from the database by their 
    #id number and returns a new Pokemon object
    def self.find(id,db)
    find_pokemon = db.execute("SELECT * FROM pokemon WHERE id =? ", id).flatten
    name = find_pokemon[1]
    type = find_pokemon[2]
    
    Pokemon.new(id: id, name: name, type: type, db: db)
    end
    #flatten-Returns a new array that is a one-dimensional of that array
    #c = [[["a"]], [["b"]]]
    #c.flatten
    #=> ["a", "b"]
end
