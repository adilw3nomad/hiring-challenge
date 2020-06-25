class CreateMarkedCategory < ActiveRecord::Migration[5.1]
  def change
    create_table :marked_categories do |t|
      t.timestamps
      t.string :name
    end
  end
end
