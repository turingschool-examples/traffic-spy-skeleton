class PayloadRequest < ActiveRecord::Base
  belongs_to :request_type
  belongs_to :url
  belongs_to :referral
  belongs_to :user_agent
  belongs_to :resolution
  validates :requested_at, :responded_in, :resolution_id, :user_agent_id, :referral_id, :ip_id, :request_type_id, :url_id, presence: true

  def self.average_response_time
    average('responded_in')
  end

  def self.max_response_time
    maximum('responded_in')
  end

  def self.min_response_time
    minimum('responded_in')
  end
  
  def self.all_response_times
    pluck('responded_in')
  end
  

end
