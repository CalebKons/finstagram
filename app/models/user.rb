class User < ActiveRecord::Base

    has_many :finstagram_post
    has_many :comments
    has_many :likes

end