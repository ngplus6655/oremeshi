class Contact < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 200, allow_blank: true }
  validates :content, length: { maximum: 400 }
end
