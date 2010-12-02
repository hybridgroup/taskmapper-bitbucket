require 'rubygems'
require 'active_support'
require 'active_resource'

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
            @resources ||= []
        end
    end
    
    class Base < ActiveResource::Base
        self.format = :json
        self.site = 'https://api.bitbucket.org/1.0/'
        
        def self.inherited(base)
            BitbucketAPI.resources << base
            super
        end
      
      def self.element_path(id, prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{id}/#{query_string(query_options)}"
      end

      def self.collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{query_string(query_options)}"
      end
    end

    class User < Base
      def repositories
        @attributes['repositories'].each do |repository|
          repository.prefix_options['username'] = @attributes['user'].username
        end
      end
    end

    class Repository < Base
      self.site += 'repositories/:username'

      def self.element_path(id, prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{id}/#{query_string(query_options)}"
      end
      
      def self.find_every(options)
        if options[:from].is_a?(String) || !options[:username].blank?
          User.find(options[:from].is_a?(String) || options[:username]).repositories
        else
          super(options)
        end
      end

      def issues
        #TODO : Get all issues
        Issue.find(:all, :params => {:username => self.user, :repository => self.slug})
      end

      def user
        @prefix_options['username']
      end
    end

    class Issue < Base
      self.site += 'repositories/:username/:repository'

      def self.instantiate_collection(collection, prefix_options = {})
        collection["issues"] 
      end
    end
end
