class AddImageFieldIntoGadgets < ActiveRecord::Migration
  def change
    add_column :gadgets, :image, :string
  end
end
