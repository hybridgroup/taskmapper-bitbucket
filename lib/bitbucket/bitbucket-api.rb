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
            @resources ||= []
        end
    end

    class Base < ActiveResource::Base
        self.site = "http://api.bitbucket.org/1.0/"
        def self.inherited(base)
            BitbucketAPI.resources << base
            super
        end
    end

    class Project < Base
        self.site += '/users/:project_id'

        def self.find(options = {})
            []
        end
    end
end
