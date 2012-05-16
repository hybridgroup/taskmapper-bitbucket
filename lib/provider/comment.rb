module TaskMapper::Provider
  module Bitbucket
    # The comment class for taskmapper-bitbucket
    #
    # Do any mapping between TaskMapper and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TaskMapper::Provider::Base::Comment
      #API = Bitbucket::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      
    end
  end
end
