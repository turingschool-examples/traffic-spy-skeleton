require 'json'

module DataParser
  def new_keys
    { "requestedAt"=>"requested_at",
      "respondedIn"=>"responded_in",
      "referredBy"=>"referred_by",
      "requestType"=>"request_type",
      "userAgent"=>"u_agent",
      "resolutionWidth"=>"resolution_width",
      "resolutionHeight"=>"resolution_height"
    }
  end

  def parsed(raw_payload)
    JSON.parse(raw_payload)
  end

  def formatted_payload(raw_payload)
    parsed(raw_payload).map {|key, value| [new_keys[key] || key, value]}.to_h
  end

  def formatted_client(raw_client)
    formatted_string = raw_client.gsub("&", "=").split("=")
    formatted = {}
    formatted["identifier"] = formatted_string[1]
    formatted["root_url"] = formatted_string[3]
    formatted
  end




  # user_agent = UserAgent.parse(string)
  # user_agent.browser
  # # => 'Chrome'
  # user_agent.version
  # # => '19.0.1084.56'
  # user_agent.platform
  # # => 'Macintosh'


end
