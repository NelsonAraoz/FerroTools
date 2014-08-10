# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user=User.create(email: "admin@ferrotools.com", :password => "1234567e",:confirmed_at => Time.now, :password_confirmation => "1234567e",name: "admin",lastname: "admin",phone: "33434",address: "sasd",rol: "admin")
index=Presentation.create(content: "Contenido inicial")
#Category.create(nombre: "asdasdasdqwuehuqwheuhaiudsh")