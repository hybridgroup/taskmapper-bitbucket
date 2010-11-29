require 'rubygems'
require 'active_support'
require 'active_resource'

module BitbucketAPI
    class Error < StandardError; end
    class << self
        def authenticate(email, password)
            @email = email
            @password = password
            self::Base.user = email
            self::Base.password = password
        end

        def resources
            @resources 
        end
    end
end
