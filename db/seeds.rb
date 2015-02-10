# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create default users, one admin and one standard
admin = User.create!(first_name: 'Alex', last_name: 'Vallejo',
                     email: 'vallejo.alex@gmail.com', password: 'password',
                     password_confirmation: 'password', approved: true,
                     status: 'active')

standard_user = User.create!(first_name: 'Drew', last_name: 'Land',
                             email: 'alex.v@pitt.edu', password: 'password',
                             password_confirmation: 'password', approved: true,
                             status: 'active')

# Create the defailt exec positions and assign all to the default user
Position.create(name: 'Secretary', user_id: 1)
Position.create(name: 'President', user_id: 1)
Position.create(name: 'Treasurer', user_id: 1)

# Create the default event type and assign user 2 as it's admin
EventType.create(name: 'Miscellaneous')
Position.create(user_id: 2, event_type_id: 1)
