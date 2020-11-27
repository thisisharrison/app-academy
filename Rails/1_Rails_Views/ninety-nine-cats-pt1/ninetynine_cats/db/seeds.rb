# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Cat.destroy_all

c1 = Cat.create!(name: 'Meow', sex: 'F', color: 'purple', birth_date: Date.new(1993, 10, 30), description: 'first')
c2 = Cat.create!(name: 'NewYear', sex: 'M', color: 'black', birth_date: Date.new(2000, 12, 31))
c3 = Cat.create!(name: 'Valentine', sex: 'F', color: 'orange', birth_date: Date.new(2020, 2, 14))

r1 = CatRentalRequest.create!(cat_id: c1.id, start_date: Date.new(2020, 10, 29), end_date: Date.new(2020, 10, 31))