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
      def self.find(mode, attributes = {})
        if !mode.nil? and mode == :all
          Bucketface.list_repos(attributes[:username])
        end
      end

      def issues
        Issue.find(:all, :username => 'cored', :slug => 'test-repo')
      end
    end

    class Issue
      def self.find(mode, attributes = {})
        if !mode.nil? and mode == :all
          Bucketface.issues(attributes)
        end
      end
    end

end
