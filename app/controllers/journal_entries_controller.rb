class JournalEntries < ApplicationController

    get "/journal_entries" do 
        @journal_entries = JournalEntry.all 
        erb :"/journal_entries/index"
    end

    #get journal_entries/new to render a form to create a new entry
    get '/journal_entries/new' do 
        erb :"/journal_entries/new"
    end

    #post journal_entries to create a new journal entry
    post '/journal_entries' do 
        redirect_if_not_logged_in
        if params[:content] != ""
            @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
            flash[:message] = "Congrats on your new journal entry."
            redirect "/journal_entries/#{@journal_entry.id}"
        else
            flash[:message] = "Something went wrong."
            redirect :"/journal_entries/new"
        end
    end

    #index route for all journal entries
    get '/journal_entries/index' do 
        erb :"/journal_entries/index"
    end

    #show route for a journal entry
    get '/journal_entries/:id' do 
        set_journal_entry
        erb :"/journal_entries/show"
    end

    #send us to journal_entries/edit.erb
    get '/journal_entries/:id/edit' do
        set_journal_entry
        redirect_if_not_logged_in
        if owns?(@journal_entry)
            erb :"/journal_entries/edit"
        else
            redirect "/users/#{current_user.id}"
        end
        
    end

    #update journal entry in DB
    patch '/journal_entries/:id' do
        #1. Find journal entry
        set_journal_entry
        redirect_if_not_logged_in
        if owns?(@journal_entry) && params[:content] != ""
            #2. Update the journal entry
            @journal_entry.update(content: params[:content])
            #3. redirect to journal entry show page
            redirect "/journal_entries/#{@journal_entry.id}"
        else
            redirect "/users/#{current_user.id}"
        end
    end

    delete "/journal_entries/:id" do 
        set_journal_entry
        if owns?(@journal_entry)
           @journal_entry.destroy
        end
        redirect "/journal_entries"
    end


    private 

    def set_journal_entry
        @journal_entry = JournalEntry.find(params[:id])
    end
end