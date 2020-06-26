class AddDefaultValueToBackgroundUrl < ActiveRecord::Migration[6.0]
  def change
    change_column_default :backgrounds, :url, from: nil, to: ""
  end
end
