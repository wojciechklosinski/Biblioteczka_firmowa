# frozen_string_literal: true

# Create a main sample user.
Book.create!(author: 'Mickiewicz',
             title: 'Dla ciekawskich',
             description: 'Bardzo ciekawa książką, serio.',
             content: 'Witamy w książce mojej zapraszamy do lektury....',
             price: 10)

# Generate a bunch of additional users.
99.times do |_n|
  name  = Faker::Name.name
  title = Faker::Lorem.words(number: rand(2..5)).join(' ')
  body = Faker::Lorem.words(number: rand(2..20)).join(' ')
  content = Faker::Lorem.words(number: rand(2..40)).join(' ')
  Book.create!(author: name,
               title: title,
               description: body,
               content: content,
               price: 2)
end

User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             balance: 20)

# Generate a bunch of additional books.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               balance: 10)
end

# Loans
books = Book.all
user  = User.first
borrowed = books[2..20]
borrowed.each { |book| user.borrow(book) }

# Historical loans
user = User.first
50.times do
  name  = Faker::Name.name
  title = Faker::Lorem.words(number: rand(2..5)).join(' ')
  user.historical_loans.create!(author: name,
                                title: title,
                                borrow_time: Time.zone.now,
                                price: 2)
end
