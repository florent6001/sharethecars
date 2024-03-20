class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  has_many :reservations

  def pending_reservations
    reservations.where(done: false).order('start_date DESC')
  end
end
