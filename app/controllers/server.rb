module RushHour

  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
     # create a parser to do something like this to parse params when registering?

     # identifier, rootUrl = Parser.new(params[:register])

     # do something like this to parse parameters (taken from class example)

     # data = JSON.parse(params[:genre]) # this has to be parsed because it's a string

     # genre = Genre.new(data)
   end
  end

end
