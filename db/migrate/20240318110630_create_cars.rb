class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :color
      t.string :plate_number
      t.references :company, null: false, foreign_key: true
      t.float :base_kilomoters

      t.timestamps
    end
  end
end
