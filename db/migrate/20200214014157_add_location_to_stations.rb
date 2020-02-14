class AddLocationToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :location, :string
  end
end
