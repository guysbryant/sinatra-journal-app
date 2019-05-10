class JournalEntries < ApplicationController

    #get journal_entries/new to render a form to create a new entry
    get '/journal_entries/new' do 
        erb :"/journal_entries/new"
    end

    #post journal_entries to create a new journal entry
    post '/journal_entries' do 
        
    end

    #show route for a journal entry
    get '/journal_entries/show' do 
        erb :"/journal_entries/show"
    end

    #index route for all journal entries
    get '/journal_entries/index' do 
        erb :"/journal_entries/index"
    end
end