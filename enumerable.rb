module Enumerable
	def my_each
		for x in self
			yield(x)
		end
		self
	end
#-----------------------------------------
	def my_each_with_index
		n = 0
		for x in self
			yield(x, n)
			n += 1
		end
		# x = 0
		# until x >= self.length
		# 	yield(self[x], x)
		# 	x += 1
		# end
		self
	end
#-----------------------------------------
	def my_select
		if (self.is_a? Array) || (self.is_a? Range)
			obj = []
			self.my_each { |x|
				obj << x if yield(x)
			}
		else
			obj = {}
			self.my_each { |x| obj[x.first] = x.last if yield(x) }
		end
		obj
	end
#-----------------------------------------
	def my_all?(arg = nil)
		boo = true
			self.my_each { |x| 
				if arg
					boo = false if !x.is_a?arg
				else
					boo = false if !yield(x)
				end
				}
			# self.my_each { |x|
				# boo = false if !yield(x)
			# }
		boo
	end
#-----------------------------------------
	def my_any?(arg = nil)
		boo = false
			self.my_each { |x| 
				if arg
					boo = true if x.is_a?arg
				else
					boo = true if yield(x)
				end
				}
		boo
	end
#-----------------------------------------
	def my_none?(arg = nil)
		boo = true
			self.my_each { |x| 
				if arg
					boo = false if x.is_a?arg
				else
					boo = false if yield(x)
				end
			}
		boo
	end
#-----------------------------------------
	def my_count
		num = 0
		self.my_each { |x|
			if block_given?
				num += 1 if yield(x)
			else
				num += 1
			end
		}
		num
	end
#-----------------------------------------
	def my_map
		arr = []
		self.my_each { |x| arr << yield(x) }
		arr
	end
	# a = [2,3,4,5,6,7]
	# rounded = Proc.new { |r| r.floor }
	# floats = [1.2, 3.45, 0.91, 7.727, 11.42, 482.911]
	# print a.my_map { |x| x ** 2 }  # [4, 9, 16, 25, 36, 49]
	# print a.my_map { "cat" }       # ["cat", "cat", "cat", "cat", "cat", "cat"]
	# print floats.my_map(&rounded)  # [1, 3, 0, 7, 11, 482]
#-----------------------------------------
		def my_inject(arg = 0)
			memo = 1
			adds = false
			my_each_with_index do |e, i|
				(adds = true if memo != self[0]) if i == 1
				memo = yield(memo, e)
			end
			adds ? (memo = memo - 1 + arg) : (memo *= arg if arg != 0)
			memo
		end
		# b = [2,4,5]
		# puts b.my_inject     { |sum, n| sum + n } # 11
		# puts b.my_inject(17) { |sum, n| sum + n } # 28
		# puts b.my_inject     { |sum, n| sum * n } # 40
		# puts b.my_inject(17) { |sum, n| sum * n } # 680
#-----------------------------------------
	def multiply_els(arg = 0)
		i = 1
		my_each { |x| i *= x }
		i
	end
#-----------------------------------------
end

