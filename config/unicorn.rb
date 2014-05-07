# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 4)
timeout 30
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
    MongoMapper.database.connection.close

    old_pid = '/tmp/unicorn.pid.oldbin'
    if File.exists?(old_pid) && server.pid != old_pid
      begin
        Process.kill("QUIT", File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
      end
    end
end 

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
  
  mongo_conf = YAML.load(File.read(File.expand_path(Rails.root.join("config","mongo.yml"))))["development"]
      
  begin
    include MongoMapper
    mongo_logger = Logger.new(STDOUT)
    MongoMapper.database = mongo_conf["database"]
    MongoMapper.setup(Rails.env, :logger => Rails.logger)
    MongoMapper.connection = Mongo::Connection.new(mongo_conf["host"], mongo_conf["port"], :logger => mongo_logger)
    MongoMapper.database.authenticate(mongo_conf["username"], mongo_conf["password"])
    ActionController::Base.rescue_responses['MongoMapper::DocumentNotFound'] = :not_found
    MongoMapper.database.connection.connect_to_master
  rescue
    Rails.logger.error("Couldn't connect to Mongo Server : #{mongo_conf.inspect}")
  end

end