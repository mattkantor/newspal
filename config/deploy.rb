# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

# ENV['SENTRY_API_ENDPOINT'] : "https://app.getsentry.com"
# ENV['SENTRY_ORG']          : "propellerhead-zk"
# ENV['SENTRY_PROJECT']      : "newsy"
# ENV['SENTRY_API_KEY']      : "0895c9ac5360465aa513a47e1bcbe5bed81a3c7bc83a43c3af7d9e4b55670484"

set :sentry_api, "https://app.getsentry.com"
set :sentry_org, "propellerhead-zk"
set :sentry_project, "newsy"
set :sentry_api_key, "0895c9ac5360465aa513a47e1bcbe5bed81a3c7bc83a43c3af7d9e4b55670484"
set :test_log, "logs/capistrano.test.log"
set :application, "objectivity"

set :repo_url, "http://github.com/mattkantor/newspal.git"
set :deploy_to, '/home/rails/rails_project'
set :pty, true
set :bundle_flags, '--deployment --quiet'
#set ssh_options[:keys]="~/.ssh/id_rsa"

set :ssh_options, {:forward_agent => true}
#before 'deploy:check_specs'
after 'deploy:publishing', 'deploy:restart'
# after 'deploy:published', 'sentry:notify_deployment'
# after 'deploy:starting', 'sidekiq:quiet'
# after 'deploy:reverted', 'sidekiq:restart'
# after 'deploy:published', 'sidekiq:restart'

namespace :sentry do
  task :notify_deployment do
    run_locally do
      require 'uri'
      require 'net/https'

      puts "Notifying Sentry of release..."
      uri = URI.parse("https://app.getsentry.com")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      req = Net::HTTP::Post.new("/api/0/projects/propellerhead-zk/newsy/releases/", initheader={'Content-Type' =>'application/json'})
      req.basic_auth("c239fce47a1548df839b94dbc893fcff2612e9193a1a4c9393f1619719a03825", '')
      req.body = %Q[{"version":"#{fetch(:release_timestamp)}","ref":"#{fetch(:current_revision)}"}]

      response = http.start { |h| h.request(req) }
      puts "Sentry response: #{response.body}"
    end
  end
end

namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      puts capture("pgrep -f 'sidekiq' | xargs kill -TSTP")
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :sidekiq
    end
  end
end

namespace :deploy do

  desc "Make sure all specs pass"
  task :check_specs do
    begin
      puts "Updating dependencies..."
      run "cd #{release_path} && bundle install"
      puts "Generating test database..."
      run "cd #{release_path} && rake db:setup RAILS_ENV=test"
      puts "Checking specs..."
      system("cd #{release_path} && bundle exec rspec .") or raise "One or more specs are failing. Come back when they all pass."
      @failed = false
    rescue Exception => e
      puts e
      @failed = true
    end
    abort if @failed
  end

end
namespace :deploy do
  task :restart do
    #invoke 'unicorn:restart'
    on roles(:app) do
        #puts "updating python"
        #execute! "pip3 install -r /home/rails/rails_project/current/python/requirements.txt"

        puts "restarting unicorn..."
        execute!  :sudo, :systemctl, :restart, :unicorn
        # => execute! :sudo, :service, :unicorn, :restart

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
