class CreateTrains < ActiveRecord::Migration[6.0]
  def change
    create_table :trains do |t|
      t.string :name
      t.string :color
      t.string :img_url
      t.string :destination
      t.string :status
      t.string :status_description

      t.timestamps
    end
  end
end
