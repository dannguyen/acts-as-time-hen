

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)



ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do

  create_table :authors do |t|
    t.string :name
    t.timestamps
  end

  create_table :books do |t|
    t.string :title
    t.integer :author_id
    t.integer :word_count
    t.timestamp :published_at
    t.timestamps
  end
end


include TimeHen

class Author < ActiveRecord::Base
   has_many :books
   include TimeHen::Base
end

class Book < ActiveRecord::Base
  belongs_to :author 
end 