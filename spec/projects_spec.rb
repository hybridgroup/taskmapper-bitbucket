require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bitbucket::Project" do
    before(:all) do 
        headers = {}
        ActiveResource::HttpMock.respond_to do |mock|
            mock.get '/1.0/users/cored/?format=xml', headers, fixture_for('projects'), 200
        end
    end

    before(:each) do 
        @ticketmaster = TicketMaster.new(:bitbucket, {})
        @klass = TicketMaster::Provider::Bitbucket::Project
    end

    it "should be able to load all projects" do 
        @ticketmaster.projects.should be_an_instance_of(Array)
    end
end
