class MeterDayDatasController < ApplicationController
  def index
    # @meter_days_data = MeterDayData.search("#{params[:m_id]}", "#{params[:start_date]}", "#{params[:end_date]}")
    @meter_days_data = MeterDayData.search("#{params[:meter_id]}", "2012-07-26", "2012-08-02")
  end
end