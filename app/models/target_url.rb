class TargetURL < ActiveRecord::Base
  belongs_to :payload_request

  validates :name, presence: true
end
