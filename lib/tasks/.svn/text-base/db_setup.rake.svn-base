env = ENV['RAILS_ENV']||'development'
database = "spot_#{env}"
user = "spotuser_#{env[0..0]}"
def connect
  ActiveRecord::Base.establish_connection(
                     :adapter => 'mysql',
                     :host => 'localhost',
                     :username => 'root',
                     :password => '88318831',
                     :database => 'mysql'
                     )
end

task :db_setup do
  ActiveRecord::Schema.define do
    connect
    begin
      create_database database
    rescue
    end
    execute "create user #{user}@localhost identified by 'ror'"
    execute "grant all privileges on #{database}.* to '#{user}'@'localhost'"
  end
end

task :db_clean do
  ActiveRecord::Schema.define do
    connect
    begin
      execute "drop user '#{user}'@'localhost'"
    rescue
    end
    drop_database database
  end
end
