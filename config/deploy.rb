require 'capistrano/ext/multistage'
require "bundler/capistrano"

set :application, "birdvision"
set :repository, "git@github.com:rahulkavale/tryingToDeploy.git" # "git@github.com:bvcteam/birdvision.git"
set :stages, %w(production qa development)
set :default_stage, "development"

set :user, "www-data"
set :group, "www-data"

set :deploy_to, "/var/www/apps/#{application}"
set :scm, :git
set :use_sudo, false
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

set :bundle_gemfile,  "Gemfile"
set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
set :bundle_flags,    "--deployment --quiet"
set :bundle_without,  [:development, :test]
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :gems do

  desc "Installs any 'not-yet-installed' gems on the production server or a single gem when the gem= is specified."
  task :install do
    if ENV['gem']
      puts "\n\n=== Installing #{ENV['gem']}! ===\n\n"
      run "gem install #{ENV['gem']}"
    else
      puts "\n\n=== Installing required RubyGems! ===\n\n"
      run "cd #{current_path}; rake gems:install RAILS_ENV=#{stage}"
    end
  end

end
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 desc "Populates the Production Database"
 task :seed do
     puts "\n\n=== Populating the Production Database! ===\n\n"
     run "cd #{current_path}; rake db:seed RAILS_ENV=#{stage}"
   end
 end
