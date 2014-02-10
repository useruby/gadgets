class CreateGadgetsTable < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
      t.string :name
      t.string :description
    end
  end
end
