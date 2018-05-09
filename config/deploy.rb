# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "objectivity"

set :repo_url, "http://github.com/mattkantor/newspal.git"
set :deploy_to, '/var/www/wedaways'
set :pty, true
#set ssh_options[:keys]="~/.ssh/id_rsa"

set :ssh_options, {:forward_agent => true}

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    #invoke 'unicorn:restart'
    on roles(:app) do
        puts "restarting unicorn..."
        execute! :sudo, :service, :unicorn, :restart

        sleep 5
        puts "whats running now, eh unicorn?"
        execute "ps aux | grep unicorn"
      end
  end
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
