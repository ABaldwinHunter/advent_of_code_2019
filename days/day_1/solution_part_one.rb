# fuel = (mass / 3.0).floor - 2
# read in file
# get fuel for each module
# return result
#

def calculate_fuel_for_file(path)
  masses = File.read(path).split("\n").map(&:to_i)
  total = masses.reduce(0) { |total, mass| total + calculate_fuel_for_module(mass) }

  puts "total is #{total}"
end

def calculate_fuel_for_module(mass)
 (mass / 3) - 2
end

calculate_fuel_for_file(ARGV.first)
