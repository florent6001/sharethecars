class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.text :comment
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
