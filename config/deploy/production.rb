set :rails_env, 'production'
set :bundle_flags, '--no-deployment'
set :deploy_to, "/home/ubuntu/openai"

set :application, 'openai'
set :repo_url, "git@github.com:TOMOSIA-VIETNAM/chatgpt-ruby-sample.git"

set :branch, 'master'
# ask :branch, nil || :main

# Default value for linked_dirs is []
append :linked_files, '.env'

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
