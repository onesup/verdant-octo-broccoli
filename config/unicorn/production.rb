domain = "dffdf.xyz"

APP_PATH = "/home/deploy/#{domain}/current"

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout Integer(ENV['WEB_TIMEOUT'] || 240)
preload_app true

working_directory "/home/deploy/#{domain}/current"

stderr_path APP_PATH + '/log/unicorn.stderr.log'
stdout_path APP_PATH + '/log/unicorn.stdout.log'

pid APP_PATH + '/tmp/pids/unicorn.pid'
listen "/tmp/unicorn.#{domain}.sock"
before_fork do |server, worker|

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
