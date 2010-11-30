require 'rubygems'
require 'active_support'
require 'active_resource'

module BitbucketAPI
    class Error < StandardError; end

    class << self
      def authenticate(username, password)
        @username = username 
        @password = password
        self::Base.user = username
        self::Base.password = password
      end

      def resources
        @resources ||= []
      end
    end

    class Base < ActiveResource::Base
      self.site = 'https://api.bitbucket.org/1.0'
      def self.inherited(base)
        BitbucketAPI.resources << base
        super
      end
    end

    class Project < Base
      def tickets(options = {})
        Ticket.find(:all, :params => options.update(:username => username))
      end
    end

    class Ticket < Base
      self.site += '/repositories/:username/bitbucket/issues/'
    end

end
