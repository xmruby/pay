class Meter < ActiveRecord::Base
  set_table_name "Meter"
  set_primary_key :M_Id
  has_many :pay_records, :foreign_key => 'M_id'
  has_one :meter_data, :foreign_key => 'M_ID'
  # belongs_to :meter_type, :foreign_key =>'Mtypeid'

  # scope :select_test, ->{where('M_Id > 3 AND M_Id <20 ')}
end