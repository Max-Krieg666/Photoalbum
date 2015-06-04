class TableOfAssesment < ActiveRecord::Base
  belongs_to :owner
  belongs_to :photo

  validates_uniqueness_of :owner, scope: [:photo]
  validates :rate, inclusion: {in: 1..5}
end