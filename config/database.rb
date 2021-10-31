configure do
  # Log queries to STDOUT in development
 if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    set :database, {
      adapter: "sqlite3",
      database: "db/db.sqlite3"
    }
  else

    db_url = 'postgres://qzngbwwlvvnmsp:57883cd5ce8a4c78e13321f85e1e425552bcda035e533784ba0231513455c18b@ec2-35-169-43-5.compute-1.amazonaws.com:5432/d1ljbd8h69dad4'
    db = URI.parse(ENV['DATABASE_URL'] || db_url)
    set :database, {
      adapter: "postgresql",
      host: db.host,
      username: db.user,
      password: db.password,
      database: db.path[1..-1],
      encoding: "utf8"
    }
  end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end