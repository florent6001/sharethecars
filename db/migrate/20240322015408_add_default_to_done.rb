class AddDefaultToDone < ActiveRecord::Migration[7.1]
  def change
    change_column_default :reservations, :done, from: nil, to: false
  end
end
