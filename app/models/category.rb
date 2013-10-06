class Category < ActiveRecord::Base
  # validations
  validates :title, presence: true

  # translations and edit history
  translates :title, :versioning => true
  has_paper_trail

  # nesting
  acts_as_tree

  # associations
  has_many :softwares
end
