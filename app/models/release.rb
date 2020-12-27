class Release < ApplicationRecord
  has_and_belongs_to_many :genres
end
