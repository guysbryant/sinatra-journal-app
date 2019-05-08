class UsersController < ApplicationController 
    #what routes do I need for login?
    #the purpose of this route is to render the login page (form)
    get '/login' do 
        erb :login
    end

    #the purpose of this route is to receive the login form,
    #find the user, and log the user in; aka create a session
    post '/login' do #adding a key/value pair to the session hash
        # Find the User
        @user = User.find_by(email: params[:email])
        # Authenticate the user 
        if @user.authenticate(params[:password])
            # log the user in aka create the user session
            session[:user_id] = @user.id
            # redirect to the user's landing page (show?, index? dashboard?)
            puts session
            redirect "users/#{@user.id}"
        else
            # tell user they entered invalid credentials
            # redirect them to the login page
        end
    end

    #what routes do I need for signup?
    get '/sigup' do 
    end

    #user show route
    get '/users/:id' do 
        "this will be my user show route"
    end
end