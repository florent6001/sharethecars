class AddKilometersDoneToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :kilometers_done, :integer
  end
end
