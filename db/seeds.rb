# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user=User.create(email: "nelsonaraoz@ymail.com",encrypted_password:"$2a$10$yuIkH85VvhWJQuSzn/eHZu5iGUsauZao3LRU9RoYyjHkllYpxTrw2",name: "nelson",lastname: "araoz",phone: "33434",address: "sasd",remember_created_at: "2014-03-22 01:44:45.854526",sign_in_count: "1",rol: "regular")