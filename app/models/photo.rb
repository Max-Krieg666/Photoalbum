class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>",:thumb => "100x100>" }
  belongs_to :album

  validates :image, attachment_presence: true,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 2.megabytes },
            attachment_file_name: {:matches => [/png\Z/, /jpe?g\Z/]}
  validates :album_id, presence: true
  validates :title, length: {maximum: 40}
  validates :description, length: {maximum: 200}
end
