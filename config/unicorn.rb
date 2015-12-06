# config/unicorn.rb
APP_PATH = File.expand_path('../..', __FILE__)

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 15)
timeout Integer(ENV['WEB_TIMEOUT'] || 240)
preload_app true

domain = "dffdf.xyz"
working_directory "/home/deploy/#{domain}/current"

stderr_path APP_PATH + '/log/unicorn.stderr.log'
stdout_path APP_PATH + '/log/unicorn.stdout.log'

pid APP_PATH + '/tmp/pids/unicorn.pid'
listen "/tmp/unicorn.#{domain}.sock"

before_fork do |server, worker|

  # https://gist.github.com/defunkt/206253#file-gistfile1-rb-L29
  #old_pid = Rails.root + '/tmp/pids/unicorn.pid.oldbin'
  #if File.exists?(old_pid) && server.pid != old_pid
  #  begin
  #    Process.kill("QUIT", File.read(old_pid).to_i)
  #  rescue Errno::ENOENT, Errno::ESRCH
  #    someone else did our job for us
    #end
  #end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && old_pid != server.pid
     begin
       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
       Process.kill(sig, File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
       # nothing
     end
  end

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end

# To unicorn master process always use current Gemfile. Otherwise it will point
# a release directory which will soon be deleted after a certain number of deployments.
before_exec do|server|
  ENV['BUNDLE_GEMFILE'] = APP_PATH + '/Gemfile'
end
