class OperatingSystemSoftware < ActiveRecord::Base
  belongs_to :operating_system
  belongs_to :software
end
