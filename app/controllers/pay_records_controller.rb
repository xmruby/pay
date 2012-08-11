class PayRecordsController < ApplicationController
  def index(id)
    @records = PayRecord.find(:all, :conditions => "M_id = #{id}")
  end

  def show
    @show_records = PayRecord.find(:all, :conditions => "M_id = #{params[:id]}")    
  end
end