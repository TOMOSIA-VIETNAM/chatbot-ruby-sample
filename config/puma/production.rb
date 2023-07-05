#!/usr/bin/env puma

root = "/home/ubuntu/openai/current"
shared_path = "/home/ubuntu/openai/shared"

directory "#{root}"
rackup "#{root}/config.ru"
environment 'production'

tag ''

pidfile "#{shared_path}/tmp/pids/puma.pid"
state_path "#{shared_path}/tmp/pids/puma.state"
stdout_redirect "#{shared_path}/log/puma.log", "#{shared_path}/log/puma.log", true

threads 0, 2

bind "unix://#{shared_path}/tmp/sockets/puma.sock"

workers 0

restart_command 'bundle exec puma'

prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "#{root}/Gemfile"
end
