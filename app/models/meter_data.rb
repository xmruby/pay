class MeterData < ActiveRecord::Base
  set_table_name "MeterData"
  #set_primary_keys :M_ID, :M_date

  belongs_to :meter, :foreign_key => 'M_Id'
end