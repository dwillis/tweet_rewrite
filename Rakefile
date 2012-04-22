desc "Start console for app"
task :console do
  exec('bundle exec irb -I. -rapplication')
end

desc "Run tests"
task :test do
  exec 'rspec spec'
end

# from https://github.com/gudleik/twitter-bootstrapped
namespace :bootstrap do
  # desc "One time bootstrap setup"
  task :init do
    system "mkdir -p vendor; git submodule add -f https://github.com/twitter/bootstrap.git vendor/twitter-bootstrap"
  end

  # desc 'Initialize the twitter bootstrap submodule'
  task :setup do
    `git submodule --quiet update`
  end

  # desc 'Sync twitter bootstrap repo'
  task :update_repo => :setup do
    `cd vendor/twitter-bootstrap; git checkout --quiet master; git pull --quiet origin master`
  end

  # desc 'Compile the assets. Requires lessc and uglifyjs'
  # To install: npm install -g less uglify-js
  task :make => [:update_repo] do
    `cd vendor/twitter-bootstrap; make`
  end

  def command_exists?(cmd)
    `which #{cmd} 2> /dev/null`
    $?.success?
  end

  # desc 'Compile assets if possible or use prebuilt one that twitter includes'
  task :find_or_create_zip do
    if command_exists?('lessc') && command_exists?('uglifyjs')
      puts "Compiling bootstrap.zip from latest source..."
      Rake::Task['bootstrap:make'].invoke
    else
      puts "Using latest prebuilt bootstrap.zip..."
      Rake::Task['bootstrap:update_repo'].invoke
    end
  end

  # desc 'Install and cleanup after compile'
  task :install => :find_or_create_zip do
    `unzip -d public/ vendor/twitter-bootstrap/docs/assets/bootstrap.zip`
    `cd vendor/twitter-bootstrap; git co -- .`
    `cp vendor/twitter-bootstrap/docs/assets/js/jquery.js public/bootstrap/js/`
  end

  desc 'Fetch latest version, compile if possible and install assets into the app'
  task :update => :install
end

task :default => :test
