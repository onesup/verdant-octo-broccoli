set :application, 'dffdf'
set :repo_url, 'git@github.com:onesup/verdant-octo-broccoli.git'

set :scm, :git
set :keep_releases, 5

set :deploy_via, :remote_cache
set :use_sudo, false
set :pty,  false

set :format,    :pretty
set :log_level, :info

#set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets public/system}

set :rbenv_type, :user

set :rbenv_path, "/home/deploy/.rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :bundle_roles,    :app
set :bundle_binstubs, false
set :bundle_flags, '--deployment'
after 'deploy:publishing', 'unicorn:restart'

namespace :dotenv do
  desc 'Upload dotenv file'
  task :upload do
    on roles(:app) do
      upload! StringIO.new(File.read(".env.#{fetch(:stage)}")), "#{release_path}/.env.#{fetch(:stage)}"
    end
  end
end
after 'deploy:updating', 'dotenv:upload'

