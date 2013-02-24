class Post < ActiveRecord::Base
  translate :body

  attr_accessible :body, :title

  validates :body, :presence => true, :locales => [ :en, :de ]
end
