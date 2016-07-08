class PayloadRequest < ActiveRecord::Base

  validates :url_id, :requested_at, :responded_in, :request_type_id, :resolution_id, :ip_id, :software_agent_id, presence: true

  belongs_to :resolutions
  belongs_to :urls
  belongs_to :request_types
  belongs_to :software_agents
  belongs_to :ips


  def self.most_frequent_request_type
    verbs = PayloadRequest.all.pluck(:request_type_id)
    freq = verbs.reduce(Hash.new(0)) { |hash,value| hash[value] += 1; hash }
    id = freq.max_by { |key,value| value}
    id = id.first
    RequestType.find(id).verb
  end

end
