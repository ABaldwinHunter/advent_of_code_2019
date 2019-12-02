# day 2
# 1,,2,99
# 1 -> add
# 2 -> multiple
# 99 -> halt
#
# state
#

TARGET = 19690720

nouns = 0..99
verbs = 0..99

combos = []

nouns.each do |noun|
  verbs.each do |verb|
    combos << [noun, verb]
  end
end

combos.uniq!

def run_program(combo)
  noun = combo.first
  verb = combo.last

  input_array = File.read('./input.csv').split(',').map(&:to_i)
  current_position = 0
  input_array[1] = noun
  input_array[2] = verb

  halt = false

  while halt != true
    instruction = input_array[current_position]
    first_input_position = input_array[current_position + 1]
    second_input_position = input_array[current_position + 2]
    write_position = input_array[current_position + 3]
    new_value = nil

    case instruction
    when 1
      new_value = input_array[first_input_position] + input_array[second_input_position]
    when 2
      new_value = input_array[first_input_position] * input_array[second_input_position]
    when 99
      result = input_array[0]
      puts "Input at position 0 is #{input_array[0]}"
      halt = true
    else
      raise "An error occurred! Input array: #{input_array.inspect}. Current position = #{current_position}"
    end

    input_array[write_position] = new_value
    current_position += 4
  end

  result
end

  # part 2
  #
  # determine what pair of inputs produces the output 19690720
  #

combos.each do |combo|
  result = run_program(combo)
  if result == TARGET
    puts "Hooray!"
    puts "noun is #{combo.first}"
    puts "verb is #{combo.last}"
  end
end
