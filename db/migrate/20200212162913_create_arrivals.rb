class CreateArrivals < ActiveRecord::Migration[6.0]
  def change
    create_table :arrivals do |t|
      t.integer :train_id
      t.integer :station_id
      t.string :arrival_time

      t.timestamps
    end
  end
end
