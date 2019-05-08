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

  helpers do 
    def logged_in? 
      !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) #memoization to reduce database calls
    end
  end
end
