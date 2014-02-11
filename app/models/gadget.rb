class Gadget < ActiveRecord::Base
  attr_accessible :name, :description

  scope :filter_by_name, ->(name){where("name ILIKE '#{name}%'")}
end
