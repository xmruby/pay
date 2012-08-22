class PayConfig
 class << self
    %w(wlg0801 dw bq aq tq dl ds lq hq ks).each do |v|
    	 define_method "#{v}_task" do
          select_connection(v)
      end
    end
  end

  def self.select_connection(v)
    Meter.establish_connection v
    PayRecord.establish_connection v
    MeterData.establish_connection v
  end

end