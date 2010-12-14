module TicketMaster::Provider
  module Bitbucket
    # Project class for ticketmaster-bitbucket
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      API = Bucketface::Client # The class to access the api's projects
      # declare needed overloaded methods here
       
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
        self::API.list_repos(options[:username]).collect { |repo| self.new repo }
      end

    end
  end
end


