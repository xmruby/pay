# encoding: utf-8
class Meter < ActiveRecord::Base
  set_table_name "Meter"
  set_primary_key :M_Id
  has_many :pay_records, :foreign_key => 'M_id'
  has_one :meter_data, :foreign_key => 'M_ID'

  def self.search(params)
    scope = self.scoped
    if params[:user_id].present?
      scope = scope.scoped_by_User_ID(params[:user_id])
    end
    if params[:user_name].present?
       scope = scope.scoped_by_User_Name(params[:user_name])
    end
    if params[:user_phone].present?
       scope = scope.scoped_by_User_Phon(params[:user_phone])
    end
    if params[:meter_id].present?
       scope = scope.scoped_by_Meter_ID(params[:meter_id])
    end
    scope
  end
end