class SkiArea < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :location_id, uniqueness: true, presence: true
end