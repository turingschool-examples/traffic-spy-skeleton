class PayloadRequest < ActiveRecord::Base
  validates_presence_of :url_id,
                        :requested_at,
                        :responded_in,
                        :referrer_url_id,
                        :request_type_id,
                        :parameters,
                        :event_name_id,
                        :user_system_id,
                        :resolution_id,
                        :ip_id

    belongs_to :request_type
    belongs_to :user_system
    belongs_to :url

  def self.average_response_time
    average(:responded_in).to_i
  end

  def self.max_response_time
    maximum(:responded_in).to_i
  end

  def self.min_response_time
    minimum(:responded_in).to_i
  end

  # Most frequent request type
  def self.most_frequent_request_type
    ids_and_count = group(:request_type_id).count
    id = ids_and_count.max_by {|k, v| v}.first
    where(request_type_id: id).first.request_type.verb

  end

  def self.most_frequent_request_type
    ids_and_count = group(:request_type_id).count
    id = ids_and_count.max_by {|k, v| v}.first
    where(request_type_id: id).first.request_type.verb
  end

  def self.all_http_verbs_used
    RequestType.pluck(:verb)
  end

  def self.sort_urls_by_request_freqency
    pr = PayloadRequest.group(:url_id).count
    sorted_arr = pr.sort_by { |k,v| v }.reverse
    sorted_arr.map { |elem| Url.where(id: elem[0]).first.address }
  end

  def self.browser_breakdown
    UserSystem.all.map do |sys|
      UserAgent.parse(sys.browser).browser
    end
  end

  def self.os_breakdown
    UserSystem.all.map do |sys|
      UserAgent.parse(sys.browser).platform
    end
  end

  def self.screen_resolutions
    Resolution.pluck(:width, :height)
  end

  def self.sort_events_most_received_to_least
    en = PayloadRequest.group(:event_name_id).count
    return "No events have been defined" if en == {}
    sorted_arr = en.sort_by { |k,v| v }.reverse
    sorted_arr.map { |elem| EventName.where(id: elem[0]).first.event_name}
  end
end