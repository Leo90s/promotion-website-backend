# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
set :rails_env, fetch(:stage)

set :application, "promotion_website"
set :repo_url, "git@github.com:Leo90s/promotion-website-backend.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/projects/#{fetch(:application)}_#{fetch(:rails_env)}"

set :rvm_ruby_version, 'ruby-2.5.1'
set :rvm_binary, '/usr/local/rvm/bin/rvm'
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/uploads"
append :linked_files, '.env'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5
set :keep_assets, 2

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :puma_bind,       "unix://#{shared_path}/tmp/pids/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_tag, "#{fetch(:application)}_#{fetch(:rails_env)}"
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :puma_threads, [0, 4]
set :puma_workers, 2
set :puma_env, fetch(:rack_env, fetch(:rails_env))

set :sidekiq_processes, 1
set :sidekiq_concurrency, 2

namespace :deploy do

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 3 do
      invoke 'puma:restart'
    end
  end

  after :finishing, :cleanup
end
