class MetersController < ApplicationController
  # layout "meters"
  before_filter :set_db_connection
  # , :only => [:search_meter]
  def index
  end

  def search_meter
    @meter_be_searched = Meter.search(params) if params_count >= 2
  end

  private
  def params_count
    count = 0
    if params[:user_id].blank? == false
      count = count + 1
    end
    if params[:user_name].blank? == false
      count = count + 1
    end
    if params[:user_phone].blank? == false
      count = count + 1
    end
    if params[:meter_id].blank? == false
      count = count + 1
    end
    count
  end

  def set_db_connection
    PayConfig.select_connection(params[:db])
  end
end