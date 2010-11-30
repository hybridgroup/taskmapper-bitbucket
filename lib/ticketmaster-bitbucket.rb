require File.dirname(__FILE__) + '/bitbucket/bitbucket-api.rb'

%w{ bitbucket ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
