class Gadget < ActiveRecord::Base
  scope :filter_by_name, ->(name){where("name LIKE '#{name}%'")}

  validates_presence_of :name

  mount_uploader :image, GadgetImageUploader
end
