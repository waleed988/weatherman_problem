module Yearly
    def find_average(file_name)
      return unless File.exist?(file_name)
  
      max_temp = []
      lowest = []
      humid = []
  
      File.open(file_name, 'r') do |file_object|
        file_object.readline
  
        file_object.each do |line|
          report = line.split(',')
          max_temp << report[1].to_i
          lowest << report[3].to_i
          humid << report[8].to_i
        end
      end
  
      max_temp.delete_if(&:zero?)
      puts "Highest Average is #{max_temp.sum / max_temp.length} C"
  
      lowest.delete_if(&:zero?)
      puts "Lowest Average: #{lowest.sum / lowest.length} C"
  
      humid.delete_if(&:zero?)
      puts "Average Humidity: #{humid.sum / humid.length} %"
    end
  end