require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      identifier = Identifier.new(name: params[:identifier], root_url: params[:rootUrl])

      if identifier.save
        body "{\"identifier\":\"#{params[:identifier]}\"}"
      else
        error_message = identifier.errors.full_messages.join(" ")
        status_number, message = MessageHelper.send_message(error_message)
        status status_number
        body message
      end
    end

    post '/sources/:identifier/data' do |identifier|
      unless Identifier.exists?(name: identifier)
        return status(403), body("403 Forbidden - Application URL not registered")
      end

      unless params[:payload]
        return status(400), body("Missing Payload - 400 Bad Request")
      end

      payload_hash = JSON.parse(params[:payload])

      if Ip.exists?(address: payload_hash["ip"]) && Payload.exists?(requested_at: payload_hash["requestedAt"])
        return status(403), body("403 Forbidden - Payload Exists")
      end

      PayloadHelper.add_payload(identifier, payload_hash)

      status(200)
    end

    not_found do
      erb :error
    end

    get '/sources/:identifier' do |identifier|
      @identifier = identifier
      @urls_by_popularity = Identifier.find_by(name: identifier).payloads.group(:url_id).count(:url_id).sort
      @urls_by_response_time = Identifier.find_by(name: "yahoo").payloads.group(:url_id).average(:responded_in).sort_by { |key, value| value }
      @identifier_specific_payloads = Identifier.find_by(name: identifier).payloads.to_a|| []
      root_url = "http://" + Identifier.find_by(name: identifier).root_url
      @paths = @urls_by_popularity.map do |url_id|
        full_url = Url.find_by(id: url_id[0]).address
        full_url.slice(root_url.length, full_url.length)
      end
      erb :application_details
    end
  end
end
