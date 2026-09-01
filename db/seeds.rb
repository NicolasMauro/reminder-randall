# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# One self-host user, seeded from ENV. Re-run safe.
if User.none? && ENV["RANDALL_EMAIL"].present?
  User.create!(name: ENV["RANDALL_NAME"], email: ENV["RANDALL_EMAIL"],
               phone: ENV["RANDALL_PHONE"], ics_url: ENV["RANDALL_ICS_URL"])
  puts "🥊 Created Randall user for #{ENV["RANDALL_EMAIL"]}"
end
