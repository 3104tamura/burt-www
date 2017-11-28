# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'csv'

Category.delete_all
csv_data = CSV.read(Rails.root.join('csv', 'categories.csv'), headers: true)
columns = csv_data.headers.map(&:to_sym)
values = csv_data.to_a
values.shift
values.map do |arr|
  arr[0] = arr[0].to_i
  arr
end

values.each do |value|
  Category.create(id: value[0], name: value[1])
end
