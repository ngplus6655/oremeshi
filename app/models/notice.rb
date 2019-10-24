class Notice < ApplicationRecord
  validates :content, length: { maximum: 300 }
  validates :released_at, presence: true
end
