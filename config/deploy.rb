# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'elixir.padilla.cc'
set :repo_url, 'git@github.com:dabit/phoenix.david.padilla.cc.git'

set :branch, :master
set :mix_env, :prod
set :default_env, { mix_env: "prod" }
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/www/phoenix.david.padilla.cc'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/prod.secret.exs')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}

# Default value for keep_releases is 5
set :keep_releases, 5

task :dependencies do
  on roles(:web) do |host|
    within(current_path) do
      execute(:mix, "deps.get")
    end
  end
end

# Run manually as needed
task :node_dependencies do
  on roles(:web) do |host|
    within(current_path) do
      execute(:npm, "install")
    end
  end
end

task :build do
  on roles(:web) do |host|
    within(current_path) do
      execute(:mix, "release")
    end
  end
end

task :assets do
  on roles(:web) do |host|
    within(current_path) do
      execute(:brunch, "build", "--production")
      execute(:mix, "phoenix.digest")
    end
  end
end

task :start do
  on roles(:web) do |host|
    within("#{current_path}/rel/blog/bin") do
      execute("./blog", "start")
    end
  end
end

task :stop do
  on roles(:web) do |host|
    within("#{current_path}/rel/blog/bin") do
      execute("./blog", "stop")
    end
  end
end

task :restart do
  on roles(:web) do |host|
    invoke("stop")
    invoke("start")
  end
end

before :build, :dependencies
before :build, :assets
after "deploy:published", :build
after "deploy:published", :restart

