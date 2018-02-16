# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([{ email: "admin@idb.org" }, { encrypted_password: "$2a$10$Oh5wnwT0qlU/YN1Ll6UHCuXsfC.nvLgNZfFk.YQLtc6WKAbLrLkG2" }, { user_type: "A" }])
