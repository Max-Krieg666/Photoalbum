class TableOfAssesment < ActiveRecord::Base
  belongs_to :owner
  belongs_to :photo

  validates_uniqueness_of :owner, scope: [:photo]
end