class DBConnector

  attr_accessor :db
  @@users_db=SQLite3::Database.new('db/users.db')
#  binding.pry
  def insert(query)
    @@users_db.execute(query)
  end


end
