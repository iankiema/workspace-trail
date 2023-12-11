# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Create users
user1 = User.create(username: 'john_doe', email: 'john@example.com', password_digest: 'password1')
user2 = User.create(username: 'jane_doe', email: 'jane@example.com', password_digest: 'password2')

# Create packages
package1 = Package.create(name: 'Basic Package', description: 'Includes basic amenities', price: 50.00)
package2 = Package.create(name: 'Premium Package', description: 'Includes premium amenities', price: 100.00)

# Create reservations
reservation1 = Reservation.create(user: user1, package: package1, date: Date.today)
reservation2 = Reservation.create(user: user2, package: package1, date: Date.tomorrow)
reservation3 = Reservation.create(user: user1, package: package2, date: Date.today + 2.days)

# Create an admin user
admin_user = User.create(username: 'admin_user', email: 'admin@example.com', password_digest: 'adminpassword')
Admin.create(user: admin_user)
