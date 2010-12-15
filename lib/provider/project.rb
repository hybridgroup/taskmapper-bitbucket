module TicketMaster::Provider
  module Bitbucket
    # Project class for ticketmaster-bitbucket
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      API = Bucketface::Client # The class to access the api's projects
      # declare needed overloaded methods here
      attr_accessor :name, :slug, :owner 

      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          hash = {'description' => object.description,
            'name'  => object.name,
            'slug' => object.slug, 
            'owner' => object.owner}
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
        self.new self::API.api.repo(:user => self::API.api.login, :repo => id)
      end

      def self.find(*options)
        mode = options.shift
        first = options.shift
        if mode == :all and first.is_a? Hash
          API.api.list_repos(first[:user]).collect { |repo| self.new repo }
        elsif mode == :all 
          API.api.list_repos.collect { |repo| self.new repo }
        elsif mode == :all and first.is_a? Array
          first.collect {|id| self.find_by_id(id) }
        elsif mode.is_a? Hash
          self.find_by_id(mode[:repo])
        elsif mode == :first 
          self.new API.api.repo(:user => first[:user], :repo => first[:repo])
        elsif mode.is_a? String
          self.find_by_id(mode)
        end
      end

      def tickets(*options)
        first = options.shift
        if first.nil? || (first == :all and options.nil?)
          API.api.issues({:user => API.api.login, :repo => self.name}).collect { |issue| TicketMaster::Provider::Bitbucket::Ticket.new issue }
        end
      end

    end
  end
end
