class Post < ApplicationRecord
  
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  has_many :comments, dependent: :destroy 

  has_many_attached :images
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  validates :title, presence: true, length: { maximum: 200, allow_blank: true }
  validates :body, length: { maximum: 400 }
  validates :review, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5, allow_blank: true }
  validates :price, presence: true, numericality: { only_integer: true, allow_blank: true }
  validates :user_id, presence: true, numericality: { only_integer: true, allow_blank: true }



  class << self
    def search(query)
      rel = order("title")
      if query.present?
        rel = rel.where("created_at::date = ?","#{query}" )
      end
      rel
    end
  end

end
