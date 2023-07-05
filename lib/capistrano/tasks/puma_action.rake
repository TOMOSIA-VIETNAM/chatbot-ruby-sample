# frozen_string_literal: true

namespace :puma_action do
  desc 'Restart the puma process'
  task :restart do
    on roles(:app) do
      within release_path do
        execute "sudo systemctl restart puma_openai.service"
      end
    end
  end
end
