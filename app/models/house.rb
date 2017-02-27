class House < ApplicationRecord
  has_many :nearest_stations, dependent: :destroy, inverse_of: :house
  accepts_nested_attributes_for :nearest_stations, allow_destroy: true

  validates :name, presence: true
  validates :rent, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :address, presence: true

  def set_nearest_stations
    self.nearest_stations.build
    self.nearest_stations.build
  end
end
