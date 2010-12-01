require 'rubygems'
require 'active_support'
require 'active_resource'

module BitbucketAPI
    class Error < StandardError; end

    class << self
        attr_accessor :username, :password, :host_format, :domain_format, :protocol, :port

        def authenticate(username, password)
            @username = username 
            @password = password
            self::Base.user = username
            self::Base.password = password
            resources.each do |klass|
                klass.site = klass.site_format % (host_format % [protocol, domain_format % username, ":#{port}"])
            end
        end

        def resources
            @resources ||= []
        end
    end

    self.host_format    = '%s://%s%s/1.0'
    self.domain_format  = 'api.bitbucket.org'
    self.protocol       = 'https'
    self.port           = ''

    class Base < ActiveResource::Base
        self.format = :json
        def self.inherited(base)
            BitbucketAPI.resources << base
            class << base
                attr_accessor :site_format
            end
            base.site_format = '%s'
            super
        end
    end

    class Project < Base
        self.site_format << "/users/"
    end
end
