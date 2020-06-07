ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
class Contribution < ActiveRecord::Base
  belongs_to :prefectures
end

class Comment < ActiveRecord::Base

end

class Prefecture < ActiveRecord::Base
  has_many :contributions
end