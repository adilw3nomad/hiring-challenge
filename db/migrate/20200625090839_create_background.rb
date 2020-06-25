class CreateBackground < ActiveRecord::Migration[5.1]
  def change
    create_table :backgrounds do |t|
      t.string :name
      t.string :url
      t.string :comment, null: false
    end
  end
end
