module TicketMaster::Provider
  module Bitbucket
    # Ticket class for ticketmaster-bitbucket
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      #API = BitbucketAPI::Issue # The class to access the api's tickets
      # declare needed overloaded methods here
      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          unless object.is_a? Hash
            hash = {:repository => object.repository.name}
          end
        end
      end
      
    end
  end
end
