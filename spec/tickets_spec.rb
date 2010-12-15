require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bitbucket::Ticket" do
  before(:all) do 
    @bitbucket = TicketMaster.new(:bitbucket, {:username => 'cored', :password => '2ub20'})
    @klass = TicketMaster::Provider::Bitbucket::Ticket
  end

  before(:each) do 
  end

  it "should be able to load all tickets" do
  end

end
