class User < ActiveRecord::Base 
    has_secure_password #this comes from bcrypt, compares plain string to hashing algorithm
end