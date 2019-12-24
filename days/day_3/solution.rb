# day 3
# wire crossing
# closest intersection to center of grid
file = File.read('./input.txt')
wires = file.split("\n").map { |wire_string| wire_string.split(",") }

wire_one = wires.first
wire_two = wires.last

# key: x1y1

def build_points_visited(instructions)
  current_coordinates = { x: 0, y: 0 }
  path = { 'x0y0' => true }

  instructions.each do |instruction|
    puts "instruction is #{instruction}"
    ary = instruction.split('')

    direction = ary.shift
    distance = ary.join('').to_i

    case direction
    when 'R'
      distance.times do |i|
        new_x = current_coordinates[:x] + i
        path["x#{new_x}y#{current_coordinates[:y]}"] = true
      end
      current_coordinates[:x] += distance
    when 'L'
      distance.times do |i|
        new_x = current_coordinates[:x] - i
        path["x#{new_x}y#{current_coordinates[:y]}"] = true
      end
      current_coordinates[:x] -= distance
    when 'U'
      distance.times do |i|
        x = current_coordinates[:x]
        new_y = current_coordinates[:y] + i
        path["x#{x}y#{new_y}"] = true
      end
      current_coordinates[:y] += distance
    when 'D'
      distance.times do |i|
        x = current_coordinates[:x]
        new_y = current_coordinates[:y] - i
        path["x#{x}y#{new_y}"] = true
      end
      current_coordinates[:y] -= distance
    else
      raise "Invalid direction #{direction}"
    end
  end

  path
end

def manhattan_distance(point_1, point_2)
  (point_1.first - point_2.first).abs + (point_1.last - point_2.last).abs
end

puts "Wire 1 is #{wire_one}"

points_visited_1 = build_points_visited(wire_one)
puts "*"*1000
puts "Finished wire 1!"

points_visited_2 = build_points_visited(wire_two)

puts "*"*1000
puts "Finished wire 2!"

puts "finding intersections"

intersections = []

points_visited_1.each do |key, value|
  if points_visited_2[key]
    intersections << key
  end
end

puts "found #{intersections.count} intersections"

intersections.reject! { |point| point == 'x0y0' }

puts "*"*100
puts "intersections are #{intersections}"

puts "calculating distances from center"

distances = intersections.map do |point|
  x_comma_y = point.split("x").last.split("y").map(&:to_i)

  manhattan_distance([0, 0], x_comma_y)
end

min = distances.min

puts "done calculating distances"

puts "min is #{min}!"
