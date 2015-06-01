class Comment < ActiveRecord::Base
  belongs_to :photo

  validates :photo_id, presence: true
  validates :owner_id, presence: true
  validates :content, presence: true, length: {maximum: 300}
end
