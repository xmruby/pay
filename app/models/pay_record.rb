class PayRecord < ActiveRecord::Base
  set_table_name "PayMoney_Rec"
  set_primary_keys :M_id, :Pay_Num

  belongs_to :meter, :foreign_key => 'M_id'
end
