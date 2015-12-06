set :stage, :production
set :rails_env, 'production'
set :deploy_to, '/home/deploy/dffdf.xyz'
set :rbenv_ruby, '2.2.4'
set :repo_url, 'git@github.com:onesup/verdant-octo-broccoli.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, 'production'
# set :bundle_cmd, "#{fetch(:rbenv_path)}/versions/#{fetch(:rbenv_ruby)}/bin/bundle"
# set :bundle_dir, "#{fetch(:rbenv_path)}/versions/#{fetch(:rbenv_ruby)}/bin/"
# set :sidekiq_cmd,    'bin/sidekiq'
# set :sidekiqctl_cmd, ->{ "#{fetch(current_path)} bin/sidekiqctl" }
# set :sidekiq_role, :sidekiq

server 'dffdf.xyz', user: 'deploy', roles: %w(app web db unicorn), primary: true
