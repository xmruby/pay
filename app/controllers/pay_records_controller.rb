#encoding: utf-8
class PayRecordsController < ApplicationController
  before_filter :set_session

  def index
  	@records = Meter.find(params[:meter_id]).pay_records
  end

  private
  def set_session
    page_session(params[:meter_id])
  end
end