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
  	days_power << datas[0]

  	for i in(1...datas.length) do
  		if(datas[i][:M_date].to_date - datas[i-1][:M_date].to_date == 1)
  			days_power << datas[i]
			else
				days = (datas[i][:M_date].to_date - datas[i-1][:M_date].to_date).to_i
				avg_power = get_avg_power(datas[i-1], datas[i], days)
				days_power << compensation_data(datas[i-1], days, avg_power)
			end
		end
  	days_power = days_power.flatten
  	get_finally_data(days_power, start_date, end_date)
  end

  def self.get_finally_data(days_power, start_date, end_date)
  	datas = []
  	# for day in (start_date.to_date...end_date.to_date) do day
  	# 	if()
  	# end
		for i in(1...days_power.length) do
			datas << { :power => days_power[i][:Real_z] - days_power[i-1][:Real_z], :date => days_power[i][:M_date], :spare_power => days_power[i][:SparePwr], :total_power => days_power[i][:Real_z]}
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

  def self.get_avg_power(pre_day_data, next_day_data, days)
  	avg_power = (next_day_data[:Real_z] - pre_day_data[:Real_z]) / days
  end

  # 补数据 前一天数据、无数据隔天数、每日平均用电量
  def self.compensation_data(pre_day_data, days, avg_power)
  	array_data = []
  	days.times.each { |v|
  		hs = {}
  		hs = Marshal.load(Marshal.dump(pre_day_data))
  		hs[:Real_z] = pre_day_data[:Real_z] + (avg_power * (v + 1))
  		hs[:M_date] = pre_day_data[:M_date] + (v + 1).day
  		hs[:SparePwr] = pre_day_data[:SparePwr] - (avg_power * (v + 1))
  		array_data << hs
  	}
  	array_data
  end
end