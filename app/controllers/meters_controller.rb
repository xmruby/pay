#encoding: utf-8
class MetersController < ApplicationController
  # layout "meters"
  before_filter :set_db_connection, :only => [:search]
  before_filter :check_session, :only => [:search]
  def index
    session[:id] = nil
  end

  def show_search

  end

  def search
    if params_count >= 2
      @meter_be_searched = Meter.search(params)
      if @meter_be_searched.count == 1
        session[:id] = @meter_be_searched[0].M_Id 
      end
    else
      flash[:notice] = '请填写2个或2个以上查询条件！'
      redirect_to show_search_meters_path
    end
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

  def check_session
    page_session(params[:id])
  end
end