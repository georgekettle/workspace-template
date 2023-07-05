# Create a user for testing
user = User.create!(
    first_name: 'George',
    last_name: 'Washington',
    email: 'george@mail.com',
    password: 'secret',
)

puts "User created: #{user.email}"
    