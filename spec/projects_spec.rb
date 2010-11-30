require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bitbucket::Project" do
  before(:each) do 
    @ticketmaster = TicketMaster.new(:bitbucket, {:username => 'foo', :password => '000000'})
    @klass = TicketMaster::Provider::Bitbucket::Project
  end

end
