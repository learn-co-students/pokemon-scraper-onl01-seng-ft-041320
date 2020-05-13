require 'bundler/setup'
require 'sqlite3'

Bundler.require

require 'pry'

require_relative "../lib/pokemon"
require_relative "../lib/scraper"
require_relative "sql_runner"

DB = {:conn => SQLite3::Database.new("db/pokemon.db")}
@db = SQLite3::Database.new('../pokemon.db')
@db.execute("DROP TABLE IF EXISTS pokemon;")
@sql_runner = SQLRunner.new(@db)
@sql_runner.execute_schema_migration_sql
