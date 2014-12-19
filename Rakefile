# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :docker do
  desc "build docker container image"
  task :build do
    sh "cd #{Rails.root}; bundle exec brocket build"
  end

  desc "build docker container image and push it to DockerHub"
  task :release do
    sh "cd #{Rails.root}; bundle exec brocket release"
  end
end
