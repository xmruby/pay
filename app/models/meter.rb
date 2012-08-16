# encoding: utf-8
class Meter < ActiveRecord::Base
  set_table_name "Meter"
  set_primary_key :M_Id
  has_many :pay_records, :foreign_key => 'M_id'
  has_one :meter_data, :foreign_key => 'M_ID'
  # belongs_to :meter_type, :foreign_key =>'Mtypeid'
  scope :by_user_id, ->(user_id) {where(" User_ID = ? ", user_id)}
  scope :by_user_name, ->(user_name) {where(" User_Name = ? ", user_name)}
  scope :by_user_phone, ->(v) {where(" User_Phon = ? ", v)}
  scope :by_meter_id, ->(v) {where(" Meter_ID = ? ", v)}
  scope :select_test, ->{where('M_Id > 3 AND M_Id <20 ')}

  # def index	
  # 	@per_page=params[:per_page]	
  # 	@page=params[:page]	
  # 	@next_page=@page.to_i+1  
  # end
  
  def self.search(params)
    scope = self.scoped
    if params[:user_id].blank? == false
      scope = scope.by_user_id(params[:user_id])
    end
    if params[:user_name].blank? == false
       scope = scope.by_user_name(params[:user_name])
    end
    if params[:user_phone].blank? == false
       scope = scope.by_user_phone(params[:user_phone])
    end
    if params[:meter_id].blank? == false
       scope = scope.by_meter_id(params[:meter_id])
    end
    scope
  end
end