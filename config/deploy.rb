# config valid only for current version of Capistrano
lock '3.4.0'

set :application   , 'elixir.padilla.cc'
set :repo_url      , 'git@github.com:dabit/phoenix.david.padilla.cc.git'
set :branch        , :master
set :default_env   , { mix_env: "prod" }
set :deploy_to     , '/home/deploy/www/phoenix.david.padilla.cc'
set :log_level     , :info
set :keep_releases , 5

set :linked_files, fetch(:linked_files, []).push('config/prod.secret.exs')
set :linked_dirs, fetch(:linked_dirs, []).
    push('deps', 'node_modules', 'rel', '_build', 'priv/static/css', 'priv/static/js')


task :dependencies do
  on roles(:web) do |host|
    within(current_path) do
      execute(:mix, "deps.get")
    end
  end
end

# Run manually as needed
namespace :node do
  task :dependencies do
    on roles(:web) do |host|
      within(current_path) do
        execute(:npm, "install")
      end
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

task :migrations do
  on roles(:web) do |host|
    within(current_path) do
      execute(:mix, "ecto.migrate")
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
before :build, "node:dependencies"
before :build, :assets
after "deploy:published", :build
after "deploy:published", :restart

