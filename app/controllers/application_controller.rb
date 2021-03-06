require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret" #sets a session ID in the session hash with the given value
                                  #this prevents someone from highjacking a session because they won't have the right secret
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect :"/users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  helpers do 
    def logged_in? 
      !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) #memoization to reduce database calls
    end

    def owns?(journal_entry)
        current_user == journal_entry.user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/'
      end
    end
  end
end
