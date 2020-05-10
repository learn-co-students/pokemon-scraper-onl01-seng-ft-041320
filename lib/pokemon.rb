class Pokemon
	attr_reader :id, :name, :type, :db
	@@all = []

	def initialize(name:, type:, db:, id:)
		@name = name
		@type = type
		@db = db
		@id = id
		@@all << self
	end

	def self.save(name, type, db)
    	db.execute("INSERT INTO pokemon(name, type) VALUES(?, ?)", name, type)
  	end

  	def self.find(id, db)
	    pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
	    name = pokemon[1]
	    type = pokemon[2]
	    
	    instance = Pokemon.new(id: id, name: name, type: type, db: db)
  	end
	
end
