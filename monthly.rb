module Monthly
    def find_max(file_name)
      return unless File.exist?(file_name)
  
      max_temp = []
      capture_date = []
  
      File.open(file_name, 'r') do |file_object|
        file_object.readline
  
        file_object.each do |line|
          report = line.split(',')
          max_temp << report[1].to_i
          capture_date << report[0]
        end
      end
  
      max = max_temp.max
      date = max_temp.index(max)
      temp = capture_date[date].split('-')
  
      [max, temp[1], temp[2]]
    end
  
    def find_min(file_name)
      return unless File.exist?(file_name)
  
      lowest = []
      capture_date = []
  
      File.open(file_name, 'r') do |file_object|
        file_object.readline
  
        file_object.each do |line|
          report = line.split(',')
          lowest << report[3].to_i
          capture_date << report[0]
        end
      end
  
      lowest.map! { |x| x.zero? ? 100 : x }
      min = lowest.min
      date = lowest.index(min)
      temp = capture_date[date].split('-')
  
      [min, temp[1], temp[2]]
    end
  
    def max_humid(file_name)
      return unless File.exist?(file_name)
  
      humid = []
      capture_date = []
  
      File.open(file_name, 'r') do |file_object|
        file_object.readline
  
        file_object.each do |line|
          report = line.split(',')
          humid << report[7].to_i
          capture_date << report[0]
        end
      end
  
      max = humid.max
      date = humid.index(max)
      temp = capture_date[date].split('-')
  
      [max, temp[1], temp[2]]
    end
  
    def print_chart(file_name)
      require 'colorize'
      return unless File.exist?(file_name)
  
      File.open(file_name, 'r') do |file_object|
        file_object.readline
  
        file_object.each do |line|
          report = line.split(',')
          max_temp = report[1].to_i
          lowest = report[3].to_i
  
          print "#{(report[0].split('_'))[2]}  "
          max_temp.times do
            print '+'.red
          end
          puts " - #{max_temp}C"
  
          print "#{(report[0].split('-'))[2]} "
          lowest.times do
            print '+'.blue
          end
          puts " - #{lowest}C\n\n"
        end
      end
    end
end