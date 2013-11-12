class Category < ActiveRecord::Base
  # associations
  belongs_to :platform

  # validations
  validates :title, presence: true

  # translations and edit history
  translates :title, :description, :versioning => true
  has_paper_trail

  # nesting
  acts_as_tree

  # associations
  has_many :categorizations
  has_many :softwares, through: :categorizations

end
