set :rails_env, 'production'
set :bundle_flags, '--no-deployment'
set :deploy_to, "/home/ubuntu/openai"

set :application, 'openai'
set :repo_url, "git@github.com:TOMOSIA-VIETNAM/chatgpt-ruby-sample.git"

set :branch, 'main'
# ask :branch, nil || :main

# set :ruby_dir, "#{fetch(:deploy_to)}/backend"
# set :bundle_dir, "#{fetch(:ruby_dir)}/vendor/bundle"
# set :bundle_path, fetch(:bundle_dir)
# # set :bundle_flags, '--deployment --quiet'
# set :bundle_without, %w{development test}.join(' ')
# set :bundle_gemfile, "#{fetch(:ruby_dir)}"
# set :bundle_jobs, 4

# Default value for linked_dirs is []
# append :linked_files, 'config/credentials/staging.key', 'config/database.yml'

after 'deploy:finished', 'puma_action:restart'

server '13.115.218.154',
  roles: %i[web app db],
  ssh_options: {
    user: 'ubuntu',
    keys: %w(~/.ssh/qr_code/qlear-release.pem),
    forward_agent: false,
    auth_methods: %w(publickey)
  }

set :keep_releases, 2
