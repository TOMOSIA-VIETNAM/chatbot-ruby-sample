#!/usr/bin/env puma

root_project = "#{Dir.getwd}"

directory root_project
rackup "#{root_project}/config.ru"

environment 'development'

pidfile "#{root_project}/tmp/pids/puma.pid"
state_path "#{root_project}/tmp/pids/puma.state"

threads 5, 5

# bind "tcp://0.0.0.0:3000"
port 3000

workers 0

prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "#{root_project}/Gemfile"
end
