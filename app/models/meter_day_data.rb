# encoding: utf-8
class MeterDayData < ActiveRecord::Base
  set_table_name "MeterDayData"
  belongs_to :meter, :foreign_key => 'M_Id'

  scope :by_date, ->(date) {where(" (SELECT CONVERT (VARCHAR(30), M_date, 23)) = ?", date)}
  scope :by_id_in_date, ->(m_id, start_date, end_date) {where("M_ID = ? AND M_date BETWEEN ? AND ?",m_id, start_date, end_date)}
  scope :by_id, ->(id) {where("M_Id = ?", id)}
  
  def self.search(m_id, start_date, end_date)
  	start_date = Time.zone.parse(start_date) - 1.day
  	end_date = Time.zone.parse(end_date)
  	get_days_power(by_id_in_date(m_id, start_date, end_date), start_date, end_date)

  end

  # 获取 每日数据的 数组days_power[]
  def self.get_days_power(datas, start_date, end_date)
  	days_power = []

  	while start_date <= end_date
  		if get_day_data(datas, days_power, start_date) == false
  		  days_power << { :real_z => 12, :m_date => start_date, :spare_power => 88}
  		end
	  	start_date = start_date + 1.day
  	end
  	day_power(days_power)
  end

  def self.day_power(days_power)
  	datas = []
		for i in(1...days_power.length) do  
			datas << { :power => days_power[i][:real_z] - days_power[i-1][:real_z], :date => days_power[i][:m_date], :spare_power => days_power[i][:spare_power]}
		end
		datas
  end

  def self.get_day_data(datas, days_power, day)
  	flag = false
  	datas.each do |data|
  		if(data.M_date.strftime("%Y-%m-%d") == day.strftime("%Y-%m-%d"))
  		  days_power << { :real_z => data.Real_z, :m_date => data.M_date, :spare_power => data.SparePwr}
  		  flag = true
  		end
  	end
  	flag
  end

  # 获取 某一天用电量
  def self.get_day_power(m_id, day)
  	scope = self.scoped
      scope = scope.by_id(m_id)
     scope = scope.by_date(day)
    scope
  end
end