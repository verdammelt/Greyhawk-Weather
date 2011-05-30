begin
  require 'rspec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'rspec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'greyhawkweather'

def avg_roller_mock
  roller = mock(:DieRoller)
  roller.stub(:roll) {|n, m|  n/2 + (m||0)}
  roller
end

def rigged_roller_mock(n)
  roller = mock(:DieRoller)
  roller.stub(:roll).and_return n
  roller
end
