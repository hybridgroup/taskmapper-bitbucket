require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bitbucket::Ticket" do
  before(:all) do 
    headers = {}
    ActiveResource::HttpMock.respond_to do |mock|
        mock.get "/1.0/repositories/foo/test-repo/issues", headers, fixture_for('issues'), 200
    end
    @project_id = 'test-repo'
  end

  before(:each) do 
      @ticketmaster = TicketMaster.new(:bitbucket, :username => 'foo', :password => '000000')
      @project = @ticketmaster.project(@project_id)
      @klass = TicketMaster::Provider::Bitbucket::Ticket
  end
end
