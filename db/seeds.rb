# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create(email: 'admin@gmail.com',
								    password: 'password1234',
								    password_confirmation: 'password1234')
user1.add_role('manager')
user2 = User.create( email: 'client@gmail.com',
								    password: 'password1234',
								    password_confirmation: 'password1234')
user2.add_role('user')
1.upto(5) do |i|
	ConferenceRoom.create(name: "Eintein #{i}")
end
1.upto(5) do |i|
	ConferenceRoom.create(name: "Newton #{i}")
end
