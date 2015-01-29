# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(first_name: 'Alex', last_name: 'Vallejo',
                     email: 'email@example.com', password: 'password',
                     password_confirmation: 'password', approved: true,
                     status: 'active')
admin.confirm!

standard_user = User.create!(first_name: 'Drew', last_name: 'Land',
                     email: 'drew@example.com', password: 'password',
                     password_confirmation: 'password', approved: true,
                     status: 'active')
standard_user.confirm!

EventType.create(name: 'Miscellaneous')

Position.create(name: 'President', user_id: 1)
Position.create(name: 'Treasurer', user_id: 1)
Position.create(name: 'Secretary', user_id: 1)
