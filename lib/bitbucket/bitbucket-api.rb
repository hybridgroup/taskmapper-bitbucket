require 'rubygems'
require 'bucketface'

module BitbucketAPI
    class Error < StandardError; end
        
    class << self
        attr_accessor :username, :password
        
        def authenticate(username, password)
            @username = username 
            @password = password
            resources.each do |resource|
              resource.user = @username
              resource.password = @password
            end
        end

        def resources
          @resource ||= []
        end

    end

    class Issue
    end

    class Repository
    end
    
end
