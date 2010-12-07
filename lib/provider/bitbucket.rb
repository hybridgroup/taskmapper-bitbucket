module TicketMaster::Provider
  # This is the Bitbucket Provider for ticketmaster
  module Bitbucket
    include TicketMaster::Provider::Base
    TICKET_API = Bitbucket::Ticket # The class to access the api's tickets
    PROJECT_API = Bitbucket::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Bitbucket.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:bitbucket, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.username.nil? or auth.password.nil?
        raise "Please provide at least a public username"
      end
      BitbucketAPI.username = auth.username 
      BitbucketAPI.authenticate(auth.username, auth.password)
    end
    
    # declare needed overloaded methods here
    
  end
end


