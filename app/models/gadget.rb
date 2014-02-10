class Gadget < ActiveRecord::Base
  attr_accessible :name, :description

  scope :search, ->(query){where("name ILIKE '#{query}%'")}
end
