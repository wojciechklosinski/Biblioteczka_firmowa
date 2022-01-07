# Create a main sample user.
Book.create!(author:  "Mickiewicz",
             title: "Dla ciekawskich",
             description: "Bardzo ciekawa książką, serio.")

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  title = Faker::Lorem.words(number: rand(2..5)).join(' ')
  body = Faker::Lorem.words(number: rand(2..20)).join(' ')
  Book.create!(author:  name,
               title: title,
               description: body)
end

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")