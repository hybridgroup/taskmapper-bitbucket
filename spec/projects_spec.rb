require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TaskMapper::Provider::Bitbucket::Project" do
  before(:all) do 
    @repo_name = "test-repo"
    @klass = TaskMapper::Provider::Bitbucket::Project
  end

  before(:each) do 
    #@repository = Factory.build :repository
    @repositories = [TaskMapper::Provider::Bitbucket::Project.new]
    @bitbucket = TaskMapper.new(:bitbucket, {:username => 'cored', :password => '123456'})
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

  it "should be able to find by name(id) with find method" do 
    p = @bitbucket.project.find(@repo_name)
    p.should be_an_instance_of(@klass)
    p.name.should be_eql(@repo_name)
  end

  it "should be able to get projects with array of names" do
    p = @bitbucket.projects([@repo_name])
    p.should be_an_instance_of(Array)
    p.first.should be_an_instance_of(@klass)
  end

  it "should be able to find by attributes (name and repo)" do
    p = @bitbucket.project.find(:first, {:user => 'cored', :repo => 'test-repo'})
    p.should be_an_instance_of(@klass)
  end

  it "should be able to find repos in an array" do
    p = @bitbucket.project.find(:all, ['test-repo'])
    p.should be_an_instance_of(Array)
    p.first.should be_an_instance_of(@klass)
  end
end
