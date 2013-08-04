

mongo_yaml = File.expand_path('config/mongo.yml', SKY_PATH)
mongo_config = YAML.load_file(mongo_yaml)

raise "config/mongo.yml: '#{SKY_ENV}' is nil!" unless mongo_config[SKY_ENV]

MongoDatabaseConfig = dbconfig = mongo_config[SKY_ENV]

MongoDatabase = Mongo::MongoClient.new(
  dbconfig['host'] || 'localhost',
  dbconfig['port'] || 27017,
  dbconfig['options']
)[dbconfig['db'] || 'test']

