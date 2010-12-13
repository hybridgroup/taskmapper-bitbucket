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

      def self.find(*options)
        mode = options.shift
        first = options.shift
        if mode == :all and first.is_a? Hash
          self::API.list_repos(first[:user]).collect { |repo| self.new repo }
        elsif mode.is_a? Hash
          self.new self::API.repo(:user => mode[:user], :repo => mode[:repo])
        elsif mode == :first 
          self.new self::API.repo(:user => first[:user], :repo => first[:repo])
        end
      end

    end
  end
end
