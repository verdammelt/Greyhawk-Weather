require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/greyhawkweather'

Hoe.plugin :newgem
Hoe.plugin :git
Hoe.plugin :cucumberfeatures
Hoe.plugin :flay
Hoe.plugin :flog
Hoe.plugin :reek
Hoe.plugin :roodi

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'greyhawkweather' do
  self.developer 'Mark Simpson', 'verdammelt@gmail.com'
  self.post_install_message = 'PostInstall.txt'
  self.rubyforge_name       = self.name
  self.extra_deps         = [['rangehash','>= 0.0.5']]
  self.extra_rdoc_files	= ["README.rdoc"]
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

require 'rake'
require 'rspec/core/rake_task'

remove_task :rcov

desc "Run all specs with RCov"
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov = true
  t.rcov_opts = ['--text-report', '--save', 'coverage.info', '--exclude', 'spec_helper', '--exclude', '^/']
end
