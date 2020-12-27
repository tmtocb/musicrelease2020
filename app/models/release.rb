class Release < ApplicationRecord
  has_and_belongs_to_many :genres
  has_one_attached :photo

  validates :photo, presence: true
end
