module TicketMaster::Provider
  module Bitbucket
    # Ticket class for ticketmaster-bitbucket
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      API = Bucketface::Client # The class to access the api's tickets
      # declare needed overloaded methods here
      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          hash = {:repository => object.repository,
            :user => object.user,
            :metadata => object.metadata,
            :reported_by => object.reported_by,
            :created_on => object.created_on,
            :id => object.local_id}
          super hash
        end
      end

      def self.open(project_id, *options)
        first = options.first[:params]
        self.new API.api.open_issue({:user => API.api.login, :repo => project_id}, first[:title], first[:body])
      end

    end
  end
end
