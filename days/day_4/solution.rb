# day 4 - secure container
#
# password:
# is 6 digits
# value is within range given in puzzle input
# two adjacent digits are the same (like 22 in 122345)
# going from left to right the digits never descrease, only increase or stay same
#

# range in puzzle input = 264793-803935
#
lower = 264793
upper = 803935

count = 0

def increasing_only?(ary)
  ary_length = ary.count
  index = 1
  decreasing = false
  last_number = ary[0]
  last_index = ary_length - 1

  for index in 1..last_index
    if ary[index] < last_number
      decreasing = true
      break
    else
      last_number = ary[index]
    end
  end

  !decreasing
end

def double?(ary)
  ary_length = ary.count
  last_index = ary_length - 1
  indices = 0..last_index
  double = false

  indices.each do |index|
    if index == 0
      next
    else
      previous_previous_index = index - 2
      previous_index = index - 1
      next_index = index + 1

      if (ary[index] == ary[previous_index] && ary[next_index] != ary[index] && ary[previous_index] != ary[previous_previous_index])
        double = true
        break
      end
    end
  end

  double
end

def meets_criteria?(num)
  ary = num.to_s.split("").map(&:to_i)

  double?(ary) && increasing_only?(ary)
end

nums = 264793..803935

finals = nums.select { |num| meets_criteria? num }

puts "final count is #{finals.count}"

# earlier approaches I was surprised didn't work:
#
# filtering out any numbers that included 2, 1, or 0 (909)
# filtered = nums.reject { |num| (num.to_s.include? '2') || (num.to_s.include? '1') || (num.to_s.include? '0') }

# for some reason the following returned one too few (965 instead of 966)
# count = 0
# nums.each do |num|
#   if meets_criteria? num
#     puts num
#     puts "count is #{count}"
#     count += 1
#   end
# end
#
#
# double method in part 1
#
# def double?(ary)
#   ary_length = ary.count
#   index = 1
#   last_number = ary[0]
#   double = false
#   last_index = ary_length - 1

#   for index in 1..last_index
#     if ary[index] == last_number
#       double = true
#       break
#     else
#       last_number = ary[index]
#     end
#   end

#   double
# end

