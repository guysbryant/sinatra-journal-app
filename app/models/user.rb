class User < ActiveRecord::Base 
    has_secure_password #this comes from bcrypt, compares plain string to hashing algorithm, gives authenticate method
    has_many :journal_entries
end