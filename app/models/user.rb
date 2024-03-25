class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  has_many :reservations
  has_many :feedbacks, through: :reservations
  has_one_attached :avatar

  def pending_reservations
    reservations.where(done: false).order('start_date DESC')
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
