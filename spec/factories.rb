FactoryGirl.define do
  factory :house do
    name '物件名'
    rent 5
    address '住所'
    age 10
    remark '備考'
  end

  factory :nearest_station do
    sequence(:line_name) { |n| "沿線名称#{n}" }
    sequence(:station_name) { |n| "駅名称#{n}" }
    minutes_walk 10
    house
  end

  factory :create_house_has_nearest_stations, class: House do
    name '物件名'
    rent 5
    address '住所'
    age 10
    remark '備考'

    after(:create) do |house|
      2.times do
        house.nearest_stations << create(:nearest_station, house: house)
      end
    end
  end

  factory :build_house_has_nearest_stations, class: House do
    name '物件名'
    rent 5
    address '住所'
    age 10
    remark '備考'

    after(:build) do |house|
      2.times do
        house.nearest_stations << build(:nearest_station, house: house)
      end
    end
  end

end
