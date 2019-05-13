class User < ActiveRecord::Base 
    has_secure_password #this comes from bcrypt, compares plain string to hashing algorithm, gives authenticate method
    validates :name, presence: true 
    validates :email, presence: true 
    validates :email, uniqueness: true 

    has_many :journal_entries
end