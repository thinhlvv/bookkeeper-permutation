# Calculate number of Similar Numbers
# 112 has 112, 121, 211 (3 similar numbers)
# 100 has 100 (1 similar number)
# Given integer a (1 <= a <= 2^32)
# Calculate number of similar numbers of a

p "Getting into calculate permutation of numbers"
p "Please insert number:"

def permute(n)
  return 1 if n == 0
  (1..n).reduce(:*)
end


# BookKeeper Rule
# http://web.mit.edu/neboat/Public/6.042/counting3.pdf
#
# group_digits has format:
# {digit1 => number_digits1, digit2 => number_digits2}
def bookkeeper(group_digits)
  number_digits = 0
  denominator_permute = 1
  group_digits.each do |_, n_digits|
    number_digits += n_digits
    denominator_permute *= permute(n_digits)
  end
  permute(number_digits) / denominator_permute
end

def solution(a)
  digits = a.to_s.split('')
  p digits
  group_digits = Hash.new(0).tap { |h| digits.each { |d| h[d.to_i] += 1 } }
  p group_digits
  total_cases = bookkeeper(group_digits)
  p total_cases

	# Remove all similar numbers that start with 0
  # Means: If similar number start with 0,
  # all other similar numbers that is created by other digits will be invalid
  unless group_digits[0] == 0
    group_digits[0] = group_digits[0] - 1
    total_cases = bookkeeper(group_digits)
  end

  total_cases 
end
 

num = gets.chomp
p "Permutation: #{solution("#{num}")} "
