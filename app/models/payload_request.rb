class PayloadRequest < ActiveRecord::Base
  belongs_to :response_time

  validates :url_id,           presence: true
  validates :requested_at,     presence: true
  validates :response_time_id, presence: true
  validates :referral_id,      presence: true
  validates :request_type_id,  presence: true
  validates :event_id,         presence: true
  validates :user_agent_id,    presence: true
  validates :resolution_id,    presence: true
  validates :ip_id,            presence: true

  def self.url_with_max_response_time
  
  end
end
