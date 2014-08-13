module Enumerable
	def my_each &block
		for i in self
			yield i
		end
	end
	
	def my_each_with_index &block
		index = 0
		for i in self
			yield i, index
			index += 1
		end
	end
	
	def my_select &block
		arr = []
		self.my_each {|i| arr << i if yield i }
		arr
	end
	
	def my_all? &block
		test = true
		self.my_each {|i| test = false unless yield i}
		test
	end
	
	def my_any? &block
		test = false
		self.my_each {|i| test = true if yield i}
		test
	end
	
	def my_count &block
		count = 0
		if block_given?
			self.my_each {|i| count +=1 if yield i}
		else		
			self.my_each {|i| count +=1}			
		end
		count
	end
	
	def my_map proc, &block
		arr = []
		self.my_each do |i|
			hold = proc.call i
			if block_given?
				hold = block.call hold
			end
			arr << hold
		end
		arr
	end
	
	def my_inject start = 0, &block
		total = yield start, self[0]
		self.my_each_with_index do |value,index|			
			break if self[index+1] == nil
			total = yield total, self[index+1]			
		end
		p total
	end
end


blah = ['a','b','c']
hah = [2,2,3]

#blah.my_each {|i|p i}
#blah.my_each_with_index {|i,x|p "#{i} , #{x}"}
#p blah.my_select{|i| i == 'a' || i == 'b'}
#p blah.my_all? {|i| i.length == 1}
#p blah.my_all? {|i| i.length == 2}
#p blah.my_any? {|i| i == 'c'}
#p blah.my_any? {|i| i == 'd'}
#p blah.my_count
#p blah.my_count {|i| i == 'a'}
#p blah.my_map {|i| i + 'a'}
duh = Proc.new {|i| i + 'a'}
p blah.my_map duh
p blah.my_map(duh) {|i| i + "b"}
#hah.my_inject {|x,y| x + y}
#hah.my_inject(1) {|x,y| x * y}