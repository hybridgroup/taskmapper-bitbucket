module TicketMaster::Provider
  module Bitbucket
    # Project class for ticketmaster-bitbucket
    #
    #
    class Project < TicketMaster::Provider::Base::Project
     # API = BitbucketAPI::Repository # The class to access the api's projects
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

    end
  end
end


