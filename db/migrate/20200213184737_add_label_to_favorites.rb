class AddLabelToFavorites < ActiveRecord::Migration[6.0]
  def change
    add_column :favorites, :label, :string
  end
end
