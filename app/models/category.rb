class Category < ActiveRecord::Base
  # validations
  validates :title, presence: true

  # nesting
  acts_as_tree
end
