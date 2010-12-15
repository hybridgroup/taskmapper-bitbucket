module TicketMaster::Provider
  module Bitbucket
    # Project class for ticketmaster-bitbucket
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      API = Bucketface # The class to access the api's projects
      # declare needed overloaded methods here
      attr_accessor :name 

      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          hash = {'description' => object.description,
            'name'  => object.name,
            'slug' => object.slug}
          @name = object.name
          super hash
        end
      end

      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

      def self.find_by_id(id)
        warn "Bitbucket API only finds by name" 
        self.new self::API.repo({:user => @client.user, :repo => id})
      end

      def self.find(*options)
        first = options.shift
        self::API.list_repos(first[:username]).collect { |repo| self.new repo }
      end

      def self.search(options = {}, limit = 1000)
        []
      end

      def tickets(*options)
        []
      end

      def self.find_by_attributes(attributes = {})
        []
      end
    end
  end
end
