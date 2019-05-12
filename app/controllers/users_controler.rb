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
        if @user && @user.authenticate(params[:password])
            # log the user in aka create the user session
            session[:user_id] = @user.id
            session[:user_name] = @user.name
            # redirect to the user's landing page (show?, index? dashboard?)
            redirect "users/#{@user.id}"
        else
            # tell user they entered invalid credentials
            flash[:message] = "Your credentials are invalid. Please sign up or try again."
            # redirect them to the login page
            redirect :"/login"
        end
    end

    #what routes do I need for signup?
    get '/signup' do 
        erb :signup
    end

    post '/users' do 
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            session[:user_name] = @user.name
            redirect "/users/#{@user.id}"
        else
            redirect "/signup"
        end
    end

    get '/users' do 
        erb :users 
    end

    get '/logout' do 
        session.clear
        redirect '/'
    end

    #user show route
    get '/users/:id' do 
        @user = User.find_by(id: params[:id])
        erb :"/users/show"
        # "this will be my user show route"
    end
end