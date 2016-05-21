class Message < ActiveRecord::Base
  has_many :hashtag_occurences
  has_many :hashtags, through: :hashtag_occurences

  validates :body, length: { maximum: 141 }
  validates :body, presence: true
end
