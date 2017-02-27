require 'rails_helper'

RSpec.describe HousesController, :type => :controller do
  let(:house_data) do
    create(:house)
  end

  let(:build_house_has_stations) do
    build(:build_house_has_nearest_stations)
  end

  let(:create_house_has_stations) do
    create(:create_house_has_nearest_stations)
  end

  describe 'GET #index' do
    context '正常系のテスト' do
      it '一覧表示でHTTP 200 status codeを返す' do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #show' do
    context '正常系のテスト' do
      it '詳細画面でHTTP 200 status codeを返す' do
        get :show, params: {id: house_data}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #edit' do
    context '正常系のテスト' do
      it '更新画面でHTTP 200 status codeを返す' do
        get :edit, params: {id: house_data}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET #new' do
    context '正常系のテスト' do
      it '新規登録画面ではhouseモデルは2つの最寄駅モデルを初期値として持っている' do
        get :new
        expect(assigns(:house).nearest_stations.size).to eq(2)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST #create' do
    context '正常系のテスト' do
      it '最寄駅をもつ物件モデルが登録できる' do
        house = build_house_has_stations
        stations_params = house.nearest_stations.collect do |station|
          station.attributes
        end

        expect {
          post :create, params: {house: house.attributes.merge(nearest_stations_attributes: stations_params)}
        }.to change { House.count }.by(1)
                 .and change { NearestStation.count }.by(2)
        expect(response).to be_redirect
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PATCH #update' do
    context '正常系のテスト' do
      it '最寄駅をもつ物件モデルが登録できる' do
        house = create_house_has_stations
        station = house.nearest_stations.last

        expect(house.name).not_to eq('update house name')
        expect(house.address).not_to eq('update house address')
        expect(house.rent).not_to eq(15000)
        expect(house.age).not_to eq(15)
        expect(house.remark).not_to eq('update remark')

        expect(station.line_name).not_to eq('update line name')
        expect(station.station_name).not_to eq('update station name')
        expect(station.minutes_walk).not_to eq(30)

        house.name = 'update house name'
        house.address = 'update house address'
        house.rent = 15000
        house.age = 15
        house.remark = 'update remark'

        station.line_name = 'update line name'
        station.station_name = 'update station name'
        station.minutes_walk = 30

        stations_params = house.nearest_stations.collect do |station|
          station.attributes
        end

        expect {
          patch :update, params: {id: house, house: house.attributes.merge(nearest_stations_attributes: stations_params)}
        }.to change { House.count }.by(0)
                 .and change { NearestStation.count }.by(0)

        expect(house.name).to eq('update house name')
        expect(house.address).to eq('update house address')
        expect(house.rent).to eq(15000)
        expect(house.age).to eq(15)
        expect(house.remark).to eq('update remark')

        expect(station.line_name).to eq('update line name')
        expect(station.station_name).to eq('update station name')
        expect(station.minutes_walk).to eq(30)

        expect(response).to be_redirect
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE #destroy' do
    context '正常系のテスト' do
      it '物件情報と最寄駅が削除されるか' do
        house = create_house_has_stations

        expect {
          delete :destroy, params: {id: house.id}
        }.to change { House.count }.by(-1)
                 .and change { NearestStation.count }.by(-2)
      end
    end
  end

end
