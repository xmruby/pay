class MeterDayDatasController < ApplicationController
  before_filter :set_session

  def index
    if (params[:start_date].nil? == true && params[:end_date].nil? == true)
    	@meter_days_data = MeterDayData.search("#{params[:meter_id]}", Time.now.beginning_of_month.strftime("%Y-%m-%d"), Time.now.strftime("%Y-%m-%d"))
    else
    	@meter_days_data = MeterDayData.search("#{params[:meter_id]}", "#{params[:start_date]}", "#{params[:end_date]}")
    end
  end

  def set_session
    page_session(params[:meter_id])
  end
end