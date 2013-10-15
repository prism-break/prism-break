class LicenseSoftware < ActiveRecord::Base
  belongs_to :license
  belongs_to :software
end
