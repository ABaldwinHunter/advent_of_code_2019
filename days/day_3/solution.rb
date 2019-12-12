# day 3
# wire crossing
# closest intersection to center of grid
file = File.read('./input.txt')
wires = file.split("\n").map { |wire_string| wire_string.split(",") }

wire_one = wires.first
wire_two = wires.last

def build_path(instructions, coordinates)
  path = {}

  instructions.each do |instruction|
    puts "instruction is #{instruction}"
    ary = instruction.split('')

    direction = ary.shift
    distance = ary.join('').to_i

    case direction
    when 'R'
      distance.times do |i|
        new_x = coordinates[:x] + i
        if path[new_x]
          path[new_x] << coordinates[:y]
        else
          path[new_x] = [coordinates[:y]]
        end
      end
      coordinates[:x] += distance
    when 'L'
      distance.times do |i|
        new_x = coordinates[:x] - i
        if path[new_x]
          path[new_x] << coordinates[:y]
        else
          path[new_x] = [coordinates[:y]]
        end
      end
      coordinates[:x] -= distance
    when 'U'
      distance.times do |i|
        x = coordinates[:x]
        if path[x]
          path[x] << coordinates[:y] + 1
        else
          path[x] = [coordinates[:y] + 1]
        end
      end
      coordinates[:y] += distance
    when 'D'
      distance.times do |i|
        x = coordinates[:x]
        if path[x]
          path[x] << coordinates[:y] - 1
        else
          path[x] = [coordinates[:y] - 1]
        end
      end
      coordinates[:y] -= distance
    else
      raise "Invalid direction #{direction}"
    end
  end

  path
end

def manhattan_distance(point_1, point_2)
  Math.abs(point_1.first - point_2.first) + Math.abs(point_1.last - point_2.last)
end

puts "Wire 1 is #{wire_one}"

path_one = build_path(wire_one, { x: 0, y: 0 })

puts "*"*1000
puts "Finished wire 1! path is: #{path_one}"

path_two = build_path(wire_two, { x: 0, y: 0 })

puts "*"*1000
puts "Finished wire 2! path is: #{path_two}"

puts "#{path_two.count} points in path two. #{path_one.count} points in path one."

puts "finding intersections"

intersections = []

path_one.each do |x_key, y_values|
  if (path_two_y_values = path_two[x_key])
    y_values.uniq.each do |y|
      if path_two_y_values.include? y
        intersections << [x_key, y]
      end
    end
  end
end

puts "found #{intersections.count} intersections"

puts "*"*100
puts "intersections are #{intersections}"

puts "calculating distances from center"
point = intersections.min_by { |point| manhattan_distance([0, 0], point) }

puts "done calculating distances"

puts "point is #{point}"
