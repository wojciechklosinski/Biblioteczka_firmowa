class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  has_many :users, through: :loans

  has_one_attached :image

  validates :author, presence: true, length: { maximum: 50 }
  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true	
  validates :price, presence: true,  numericality: { greater_than_or_equal_to: 0 }
  validates :content, presence: true
  validate :correct_image

  private

  def correct_image
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:image, 'has wrong format.')
    end
  end
end
