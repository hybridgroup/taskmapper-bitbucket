require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TaskMapper::Provider::Bitbucket" do
  
  it "should be able to instantiate a new instance" do
    @taskmapper = TaskMapper.new(:bitbucket, {:username=> 'foo', :password => '000000'})
    @taskmapper.should be_an_instance_of(TaskMapper)
    @taskmapper.should be_a_kind_of(TaskMapper::Provider::Bitbucket)
  end
  
end
