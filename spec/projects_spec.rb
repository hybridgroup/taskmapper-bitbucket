require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bitbucket::Project" do
    before(:all) do 
        headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/json'}
        ActiveResource::HttpMock.respond_to do |mock|
            mock.get '/1.0/repositories//repositories/', headers, fixture_for('projects'), 200 
        end
    end

    before(:each) do 
        @ticketmaster = TicketMaster.new(:bitbucket, {:username => 'foo', :password => '000000'})
        @klass = TicketMaster::Provider::Bitbucket::Project
    end

    it "should be able to load all projects" do 
        @ticketmaster.projects.should be_an_instance_of(Array)
    end
end
