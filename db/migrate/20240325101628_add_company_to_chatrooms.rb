class AddCompanyToChatrooms < ActiveRecord::Migration[7.1]
  def change
    add_reference :chatrooms, :company, null: false, foreign_key: true
  end
end
