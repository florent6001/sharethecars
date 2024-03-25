class AddKilometersToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :kilometers, :integer
    remove_column :cars, :base_kilomoters
  end
end
