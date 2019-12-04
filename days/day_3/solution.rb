# day 3
# wire crossing
# closest intersection to center of grid
file = File.read('./input.txt')
wires = file.split("\n").map { |wire_string| wire_string.split(",") }

wire_one = wires.first
wire_two = wires.last

def build_path(instructions, coordinates)
  path = []
  cardinal_direction = nil

  instructions.each do |instruction|
    puts "instruction is #{instruction}"
    ary = instruction.split('')

    direction = ary.shift
    distance = ary.join('').to_i

    case direction
    when 'R'
      distance.times do |i|
        path << { x: (coordinates[:x] + i), y: coordinates[:y] }
      end
      coordinates[:x] += distance
    when 'L'
      distance.times do |i|
        path << { x: (coordinates[:x] - i), y: coordinates[:y] }
      end
      coordinates[:x] -= distance
    when 'U'
      distance.times do |i|
        path << { y: (coordinates[:y] + i), x: coordinates[:x] }
      end
      coordinates[:x] += distance
    when 'L'
      distance.times do |i|
        path << { y: (coordinates[:y] - i), x: coordinates[:x] }
      end
      coordinates[:x] -= distance
    end
  end

  path
end
# sqrt(x2-x1)^2 + sqrt(y2-y1)^2
#
def distance(point_1, point_2)
  x2 = point_2[:x]
  y2 = point_2[:y]

  x1 = point_1[:x]
  y1 = point_1[:y]

  Math.sqrt((x2 - x1)*2) + Math.sqrt((y2 - y1)*2)
end

puts "Wire 1 is #{wire_one}"

path_one = build_path(wire_one, { x: 0, y: 0 }).uniq

puts "*"*1000
puts "Finished wire 1! path is: #{path_one}"

path_two = build_path(wire_two, { x: 0, y: 0 }).uniq

intersections = path_one.select { |point| path_two.include? point }

point = intersections.min_by { |point| distance({ x: 0, y: 0 }, point) }

puts "point is #{point}"
