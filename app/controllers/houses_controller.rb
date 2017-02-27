class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  def index
    @houses = House.all
  end

  def show
  end

  def new
    @house = House.new
    # 登録フォーム表示のために最寄駅オブジェクトをbuildする
    @house.set_nearest_stations
  end

  def edit
  end

  def create
    @house = House.new(house_params)

    if @house.save
      redirect_to @house, notice: '物件情報の登録に成功しました。'
    else
      render :new
    end
  end

  def update
    if @house.update(house_params)
      redirect_to @house, notice: '物件情報の更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    @house.destroy
    redirect_to houses_url, notice: '物件情報の削除に成功しました。'
  end

  private
  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(:name, :address, :rent, :age, :remark,
                                  nearest_stations_attributes: [:id, :line_name, :station_name, :minutes_walk])
  end
end
