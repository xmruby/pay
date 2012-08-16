class PayRecordsController < ApplicationController
  def index
    @records = PayRecord.find(:all, :conditions => "M_id = #{params[:meter_id]}")
  end
end