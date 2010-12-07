require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "BitbucketAPI" do

    before(:all) do
        headers = {'Authorization' => 'Basic Zm9vOjAwMDAwMA==', 'Accept' => 'application/json'}
        @repo_response = { :prefix => 1 }
        ActiveResource::HttpMock.respond_to do |mock|
            mock.get "/1.0/users/cored/", headers, fixture_for('projects'), 200 
            mock.get "/1.0/repositories/cored/test-repo/issues/", headers, fixture_for('issues'), 200
        end
    end

    describe "BitbucketAPI::Repository" do 
        before(:each) do 
            @call = BitbucketAPI::Repository.find(:all, :username => 'cored')
        end
        it "should extract a repository for a giving user" do 
            @call.should be_an_instance_of(Array)
        end

        it "should have an array of issues" do 
            @call.first.issues.should be_an_instance_of(Array)
        end
    end

    describe "BitbucketAPI::User" do 
        before(:each) do
            @call = BitbucketAPI::User.find('cored')
        end
        it "should extract user info from a givin user" do 
            @call.user.username.should == 'cored'
        end

        it "should have a list of repositories" do 
            @call.repositories.should be_an_instance_of(Array)
        end
    end

    describe "BitbucketAPI::Issue" do 
        it "should return a list of issues for a giving user" do 
            BitbucketAPI::Issue.find(:all, :params => {:username => 'cored', :repository => 'test-repo'}).should be_an_instance_of(Array)
        end
    end
end
