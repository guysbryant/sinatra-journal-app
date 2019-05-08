require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret" #sets a session ID in the session hash with the given value
                                  #this prevents someone from highjacking a session because they won't have the right secret
  end

  get "/" do
    erb :welcome
  end

end
