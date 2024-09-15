class AddDescriptionToTransaction < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :description, :text
  end
end
