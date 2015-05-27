module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(params)
      if client.save
        "{'identifier':'#{client.identifier}'}"
      else
        status 400
      end
    end
  end
end
