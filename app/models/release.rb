class Release < ApplicationRecord
  has_and_belongs_to_many :genres
  has_one_attached :photo
  validates :photo, presence: true
  acts_as_votable

  def resized_photo
    photo.variant(resize: "200x200!")
  end
end
