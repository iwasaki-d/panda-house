class NearestStation < ApplicationRecord
  belongs_to :house

  validates :line_name, presence: true
  validates :station_name, presence: true
  validates :minutes_walk, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
