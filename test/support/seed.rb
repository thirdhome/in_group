def load_users(users)
  User.insert_all(users)
end

users = YAML.load_file(File.dirname(__FILE__) + "/users.yml")
load_users(users)
