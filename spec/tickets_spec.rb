require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bitbucket::Ticket" do
  before(:all) do 
    @bitbucket = TicketMaster.new(:bitbucket, {:username => 'cored', :password => 'yfu37samnx'})
    @klass = TicketMaster::Provider::Bitbucket::Ticket
  end

  before(:each) do 
    @projects = @bitbucket.projects
    @ticket_id = "1"
    @project = TicketMaster::Provider::Bitbucket::Project.new @projects.first
  end

  it "should be able to load all tickets" do
    tickets = @project.tickets
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to extract tickets from an array of id's" do
    tickets = @project.tickets([@ticket_id])
    tickets.should be_an_instance_of(Array)
    ticket = tickets.first
    ticket.should be_an_instance_of(@klass)
    ticket.id.should == 1
  end

  it "should be able to find a single ticket based on number attribute" do 
    ticket = @project.tickets({:number => @ticket_id})
    ticket.should be_an_instance_of(@klass)
  end

  it "should find a ticket by id(number)" do 
    ticket = @project.tickets(@ticket_id).should be_an_instance_of(@klass)
  end

  it "should be able to open a new ticket" do 
    tick = @project.ticket!({:body => "new ticket", :title => "new"})
    tick.should be_an_instance_of(@klass)
  end

end
