require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bitbucket::Project" do
  before(:all) do 
    @repo_name = "test-repo"
    @klass = TicketMaster::Provider::Bitbucket::Project
  end

  before(:each) do 
    #@repository = Factory.build :repository
    @repositories = [TicketMaster::Provider::Bitbucket::Project.new]
    @bitbucket = TicketMaster.new(:bitbucket, {:username => 'cored', :password => 'hithere'})
  end

  it "should be able to load all projects" do 
    #Bucketface::Client.stub!(:list_repos).and_return(@repositories)
    projects = @bitbucket.projects
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to find by name(id)" do
    p = @bitbucket.project(@repo_name)
    p.should be_an_instance_of(@klass)
    p.name.should be_eql(@repo_name)
  end
end
