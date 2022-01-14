# frozen_string_literal: true

# Create sample books.
Book.create!(author: 'Mickiewicz',
             title: 'Dla ciekawskich',
             description: 'Bardzo ciekawa książką, serio.',
             content: 'Witamy w naszej książce. Zapraszamy do lektury....',
             price: 10)

Book.create!(author: 'Juliusz Słowacki',
             title: 'Konrad Wallenrood',
             description: 'Słowacki wspaniałym poetą był.',
             content: 'Słowacki jest lepszy niż Mickiewicz!!!!',
             price: 5)

Book.create!(author: 'Wojtek',
             title: 'Jak zostałem koderem.',
             description: 'Przygoda Wojtka z krainy dżemów. Droga do sławy na stackoverflow.',
             content: 'Wszystko zaczęło się na Mechatronice...',
             price: 23)

Book.create!(author: 'Gombrowicz',
             title: 'Ferdydurke',
             description: 'O łydkach i upupianiu.',
             content: 'Harcerki mają grube łydki.',
             price: 1)

Book.create!(author: 'Dostojewski',
             title: 'Zbrodnia Ikara',
             description: 'Książka o Ikarze, który popełnił zbrodnię!',
             content: 'Dawno dawno temu, na lekcji Polskiego...',
             price: 10)

# Generate a bunch of additional books.
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

# Create admin user.
User.create!(name: 'Admin User',
             email: 'admin@admin.pl',
             password: 'admin123',
             password_confirmation: 'admin123',
             admin: true,
             balance: 0)

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@firmowabiblioteczka.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               balance: 10)
end

# Generate sample loans for admin user.
books = Book.all
user  = User.first
borrowed = books[2..10]
borrowed.each { |book| user.borrow(book) }

# Generate historical loans for admin user.
user = User.first
50.times do
  name  = Faker::Name.name
  title = Faker::Lorem.words(number: rand(2..5)).join(' ')
  user.historical_loans.create!(author: name,
                                title: title,
                                borrow_time: Time.zone.now,
                                price: 2)
end
