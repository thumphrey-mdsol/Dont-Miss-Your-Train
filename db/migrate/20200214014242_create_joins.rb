class CreateJoins < ActiveRecord::Migration[6.0]
  def change
    create_table :joins do |t|
      t.integer :station_id
      t.integer :train_id

      t.timestamps
    end
  end
end
