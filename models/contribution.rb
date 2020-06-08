ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
class Prefecture < ActiveRecord::Base
  has_many :contributions
end

class Contribution < ActiveRecord::Base
  belongs_to :prefecture
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :contributions
end
