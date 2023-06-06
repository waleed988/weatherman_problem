require_relative 'monthly.rb'
require_relative 'yearly.rb'

class Weather
    include Yearly
    include Monthly
  
    def get_path(args, mode = nil)
      months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
      month_tracker = []
      max_month_tracker = []
      min_month_tracker = []
  
      day = []
      min_day_tracker = []
      max_day_tracker = []
  
      max_humid = []
      min_temp_tracker = []
      max_temp_tracker = []
  
      date = args[1].split('/')
  
      if date.length == 2
        index = date[1].to_i - 1
        path = "#{args[2]}/#{args[2]}_#{date[0]}_#{months[index]}.txt"
  
        if mode
          puts '------> Average Temperature Analysis'
          find_average(path)
        else
          puts '------> Monthly Temperature Chart'
          print_chart(path)
        end
      else
        (0..11).each do |i|
          path = "#{args[2]}/#{args[2]}_#{date[0]}_#{months[i]}.txt"
          next unless File.exist?(path)
  
          temp2 = find_max(path)
  
          max_temp_tracker << temp2[0]
          max_day_tracker << temp2[2]
          max_month_tracker << temp2[1]
  
          temp1 = find_min(path)
  
          min_temp_tracker << temp1[0]
          min_day_tracker << temp1[2]
          min_month_tracker << temp1[1]
  
          temp = max_humid(path)
  
          max_humid << temp[0]
          day << temp[2]
          month_tracker << temp[1]
        end
  
        temp = max_humid.max
        index1 = max_humid.index(temp)
        mindex = month_tracker[index1].to_i
  
        temp3 = max_temp_tracker.max
        max_index = max_temp_tracker.index(temp3)
        max_month_index = max_month_tracker[max_index].to_i
  
        min_value = min_temp_tracker.min
        min_index = min_temp_tracker.index(min_value)
        min_month_index = min_month_tracker[min_index].to_i
  
        puts '------> Yearly Temperature Analysis'
        puts "Highest: #{max_temp_tracker[max_index]}C"
        puts "On #{months[max_month_index - 1]}"
        puts "#{max_day_tracker[max_index]}"
        puts "Lowest: #{min_temp_tracker[min_index]}C"
        puts "On #{months[min_month_index - 1]}"
        puts "#{min_day_tracker[min_index]}"
        puts "Humid: #{max_humid[index1]}%"
        puts "On #{months[mindex - 1]}"
        puts "#{day[index1]}"
      end
    end
end
  
mode = ARGV[0]
date = ARGV[1]
  
temp = Weather.new
if mode == '-a' && date.include?('/')
    temp.get_path(ARGV, true)
elsif mode == '-e' && !date.include?('/')
    temp.get_path(ARGV)
elsif mode == '-c' && date.include?('/')
    temp.get_path(ARGV, false)
else
    puts 'Incorrect Arguments'
end
  