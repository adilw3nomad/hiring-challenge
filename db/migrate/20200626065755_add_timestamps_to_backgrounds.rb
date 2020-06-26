class AddTimestampsToBackgrounds < ActiveRecord::Migration[6.0]
  def change
    change_table :backgrounds do |t|
      t.timestamps
    end
  end
end
