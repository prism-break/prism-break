class Categorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :software
end
