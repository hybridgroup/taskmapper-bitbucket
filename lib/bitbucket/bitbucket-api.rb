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

    class Repository
      attr_reader :username, :slug
      def initialize(slug, username)
        @slug = slug
        @username = username
      end
      def self.find(mode, attributes = {})
        repositories = []
        if !mode.nil? and mode == :all
          Bucketface.list_repos(attributes[:username]).each do |repo|
            repo = Repository.new(repo.slug, attributes[:username])
            repositories << repo
          end
        end
        repositories
      end

      def issues
        Issue.find(:all, :params => {:username => self.username, :repo => self.slug})
      end
    end

    class Issue
      def self.find(mode, attributes = {})
        if !mode.nil? and mode == :all
          Bucketface.issues(attributes[:params])
        end
      end
    end

    class User
    end

end
