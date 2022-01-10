# Create a main sample user.
Book.create!(author:  "Mickiewicz",
             title: "Dla ciekawskich",
             description: "Bardzo ciekawa książką, serio.",
             content: "Witamy w książce mojej zapraszamy do lektury....",
             price: 10)

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  title = Faker::Lorem.words(number: rand(2..5)).join(' ')
  body = Faker::Lorem.words(number: rand(2..20)).join(' ')
  content = Faker::Lorem.words(number: rand(2..40)).join(' ') 
  Book.create!(author:  name,
               title: title,
               description: body,
               content: content,
               price: 2)
end

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)