root = "#{Dir.getwd}"

bind "tcp://0.0.0.0:3000"
pidfile "#{root}/tmp/puma/pid"
state_path "#{root}/tmp/puma/state"
rackup "#{root}/config.ru"
threads 2, 4
activate_control_app
