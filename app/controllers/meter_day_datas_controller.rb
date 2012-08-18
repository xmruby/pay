class MeterDayDatasController < ApplicationController
  def index
    if (params[:start_date].nil? == true && params[:end_date].nil? == true)
    	@meter_days_data = MeterDayData.search("#{params[:meter_id]}", "2012-07-26", "2012-08-02")
    else
    	@meter_days_data = MeterDayData.search("#{params[:meter_id]}", "#{params[:start_date]}", "#{params[:end_date]}")
    end
  end
  def get_id
  	@id = params[:meter_id]
  end
end