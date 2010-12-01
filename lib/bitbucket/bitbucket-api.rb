require 'rubygems'
require 'active_support'
require 'active_resource'

module BitbucketAPI
    class Error < StandardError; end

    class << self
        attr_accessor :username, :password, :host_format 

        def authenticate(username, password)
            @username = username 
            @password = password
            self::Base.user = username
            self::Base.password = password
            resources.each do |klass|
                klass.site = host_format % username
            end
        end

        def resources
            @resources ||= []
        end
    end

    self.host_format    = 'https://api.bitbucket.org/1.0/users/%s/'

    class Base < ActiveResource::Base
        self.format = :json
        def self.inherited(base)
            BitbucketAPI.resources << base
            super
        end
    end

    class Project < Base
    end
end
