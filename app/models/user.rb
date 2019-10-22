class User < ApplicationRecord

  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 15, allow_blank: true }
  validates :login_id, presence: true, uniqueness: true, length: { minimum: 3, allow_blank: true }
  validates :gender, numericality: true
  validates :introduce, length: { maximum: 100 }
  validates :taste, presence: true, numericality: { allow_blank: true }
  validates :admin, inclusion: { in: [true, false] }

  attr_accessor :current_user
  attr_accessor :current_password

  validates :password, presence: { if: :current_password }

  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthday&.strftime(date_format).to_i) / 10000
  end

end
