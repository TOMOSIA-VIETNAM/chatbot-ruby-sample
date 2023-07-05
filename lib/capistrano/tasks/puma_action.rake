# frozen_string_literal: true

namespace :puma_action do
  desc 'Restart the puma process'
  task :restart do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          if fetch(:rails_env) == 'production'
            execute "sudo systemctl restart puma.service"
          end
        end
      end
    end
  end
end
