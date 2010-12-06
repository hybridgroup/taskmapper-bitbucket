require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "BitbucketAPI" do

    before(:all) do
        headers = {"AuthorizationBasic" => " Zm9vOjAwMDAwMA==", "Accept" => "application/json"}
        ActiveResource::HttpMock.respond_to do |mock|
            mock.get "/1.0/users/cored/", headers, [], 200 
        end
    end

    describe "BitbucketAPI::Repository" do 
        it "should extract a repository for a giving user" do 
            @repository = BitbucketAPI::Repository.find(:all, :username => 'cored')
        end
    end
end
