#!/usr/bin/env puma

root = "#{Dir.getwd}"
directory "#{root}"
rackup "#{root}/current/config.ru"
environment 'production'

tag ''

pidfile "#{root}/shared/tmp/pids/puma.pid"
state_path "#{root}/shared/tmp/pids/puma.state"
stdout_redirect '#{root}/shared/log/puma_access.log', '#{root}/shared/log/puma_error.log', true

threads 0, 2

bind 'unix://#{root}/shared/tmp/sockets/puma.sock'

workers 0

restart_command 'bundle exec puma'

prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "#{root}/current/Gemfile"
end
