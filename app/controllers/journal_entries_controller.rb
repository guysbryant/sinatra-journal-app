class JournalEntries < ApplicationController

    #get journal_entries/new to render a form to create a new entry
    get '/journal_entries/new' do 
        erb :"/journal_entries/new"
    end

    #post journal_entries to create a new journal entry
    post '/journal_entries' do 
        if !logged_in?
            redirect "/"
        end
        if params[:content] != ""
            @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
            redirect "/journal_entries/#{@journal_entry.id}"
        else
            redirect :"/journal_entries/new"
        end
    end

    #show route for a journal entry
    get '/journal_entries/:id' do 
        set_journal_entry
        erb :"/journal_entries/show"
    end

    #send us to journal_entries/edit.erb
    get '/journal_entries/:id/edit' do
        set_journal_entry
        erb :"/journal_entries/edit"
    end

    #update journal entry in DB
    patch '/journal_entries/:id' do
        #1. Find journal entry
        set_journal_entry
        #2. Update the journal entry
        @journal_entry.update(content: params[:content])
        #3. redirect to journal entry show page
        redirect "/journal_entries/#{@journal_entry.id}"
    end

    #index route for all journal entries
    get '/journal_entries/index' do 
        erb :"/journal_entries/index"
    end

    private 

    def set_journal_entry
        @journal_entry = JournalEntry.find(params[:id])
    end
end