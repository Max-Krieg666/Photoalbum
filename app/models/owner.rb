class Owner < ActiveRecord::Base
  has_many :user_usergroups
  has_and_belongs_to_many :usergroups, join_table: 'usergroups_users'
  has_many :albums

  validates :avatar,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 1.megabytes },
            attachment_file_name: {:matches => [/png\Z/, /jpe?g\Z/]}
  has_attached_file :avatar, styles: { :medium => "300x300>", :thumb => "100x100>" }

  ROLES = %w(Пользователь Модератор Администратор)
  has_secure_password
  before_validation :set_default_role, :check_bday
  validates :password, length: {minimum: 6}, if: "password.present?"
  validates :role, presence: true, inclusion: {in: 0...ROLES.size}
  validates :login, presence: true, length: {minimum: 3 ,maximum: 24},
                    uniqueness: true, exclusion: { in: %w(admin god root)}
  validates :sex, inclusion: { in: %w(м ж)}
  validates :mail, presence: true, uniqueness: {case_sensitive: false},
                   format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  def moderator?
    role==1 || administrator?
  end
  def administrator?
    role==2
  end
  def user?
    role==0
  end

  def set_default_role
    self.role||=0
  end
  
  def check_bday
    if !self.birthday.blank?
      self.errors[:birthday]<<" не существует!" if self.birthday > Time.now
    end
  end
end
