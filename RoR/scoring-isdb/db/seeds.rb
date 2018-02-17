# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
adminUsers = User.all

if adminUsers.size == 0
	u1 = User.new(id: 1, email: "admin@isdb.org", encrypted_password: "$2a$10$mEBvmL0BmrXEK03oVtrpve2jELKBNXv5mcxxWp/lhQIHRsdN9BOHq", user_name: "Admin", email_confirmed: 0, user_name: "Administrator")
	u1.save!(validate: false)

	u2 = User.new(id: 1, email: "raedazmi@gmail.com", encrypted_password: "$2a$10$mEBvmL0BmrXEK03oVtrpve2jELKBNXv5mcxxWp/lhQIHRsdN9BOHq", user_name: "Admin", email_confirmed: 0, user_name: "Administrator")
	u2.save!(validate: false)
end