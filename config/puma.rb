#!/usr/bin/env puma

root = "#{Dir.getwd}"
directory "#{root}"
rackup "#{root}/config.ru"
environment 'development'

tag ''

pidfile "#{root}/tmp/pids/puma.pid"
state_path "#{root}/tmp/pids/puma.state"
stdout_redirect "#{root}/log/puma.log", "#{root}/log/puma.log", true

threads 0, 2

bind "tcp://0.0.0.0:3000"

workers 0

restart_command 'bundle exec puma'

prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "#{root}/Gemfile"
end
