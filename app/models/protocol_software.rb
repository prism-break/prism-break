class ProtocolSoftware < ActiveRecord::Base
  belongs_to :protocol
  belongs_to :software
end
