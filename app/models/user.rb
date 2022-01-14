# frozen_string_literal: true

class User < ApplicationRecord
  has_many :loans, dependent: :destroy
  has_many :books, through: :loans
  has_many :historical_loans, dependent: :destroy

  attr_accessor :remember_token

  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :balance, presence: true,  numericality: { greater_than_or_equal_to: 0 }
  has_secure_password

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Przypisanie zmiennych pobranych z konta google do użytkownika.
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Change balance value back to 0
  def reset_balance
    update_attribute(:balance, 0)
  end

  # Check if user have the book in his library
  def borrowing?(book)
    books.include?(book)
  end

  # Borrow the book, add to user library
  def borrow(book)
    loans.create(book_id: book.id)
  end

  # Return the book, delete from loans and create new historical loan
  def return(book)
    historical_loans.create(title: book.title, author: book.author, price: loan_price(book),
                            borrow_time: loans.find_by(book_id: book.id).created_at)
    loans.find_by(book_id: book.id).destroy
  end

  # Update balance value
  def update_balance(book)
    new_balance = balance + loan_price(book)
    update_attribute(:balance, new_balance)
  end

  # Return loan price
  def loan_price(book)
    book.price * loan_length(book) if borrowing?(book)
  end

  # Return loan length
  def loan_length(book)
    1 + (Time.zone.now.to_date - loans.find_by(book_id: book.id).created_at.to_date).to_i if borrowing?(book)
  end
end
