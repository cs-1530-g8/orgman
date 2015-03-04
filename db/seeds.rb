# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create default users, one admin and one standard
admin = User.create!(first_name: 'Alex', last_name: 'Vallejo',
                     email: 'email@example.com', password: 'password',
                     password_confirmation: 'password', approved: true,
                     status: 'active')

standard_user = User.create!(first_name: 'Drew', last_name: 'Land',
                             email: 'drew@example.com', password: 'password',
                             password_confirmation: 'password', approved: true,
                             status: 'active')

# Create the defailt exec positions and assign all to the default user
Position.create(name: User::SECRETARY, user: admin)
Position.create(name: User::PRESIDENT, user: admin)
Position.create(name: User::TREASURER, user: admin)

# Create the default event type and assign user 2 as it's admin
event_type = EventType.create(name: 'Miscellaneous')
Position.create(user: standard_user, event_type: event_type)
