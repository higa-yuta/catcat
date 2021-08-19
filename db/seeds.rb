User.create!( name: "sample",
              email: "sample@example.com",
              password:              'password',
              password_confirmation: 'password',
              admin: true )

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@sample.com"
  User.create!( name: name,
                email: email,
                password:              'password',
                password_confirmation: 'password')
end