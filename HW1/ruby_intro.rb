#Author: Aditya Thagarthi Arun
#UIN: 731009189

# Part 1

# Method sum(array) takes an array of integers and returns the sum of its elements. 
    #For an empty array it should return zero
def sum arr
    
    if arr.length == 0
        return 0
        
    else 
        s = 0 # sum return variable
            
        for i in arr
            s += i
        end
        
        return s
    end
    
end

#Method max_2_sum(arr) takes an array of integers as an argument and returns the sum of its two largest elements. 
    # For an empty array it should return zero 
    # For an array with just one element, it should return that element 
def max_2_sum arr
    
    l=arr.length#length of the array
    
    if l == 0
        return 0
    
    elsif l == 1
        return arr[0]
    
    else
        
        arr_sort=arr.sort
        l1 = arr_sort[l-1]
        l2 = arr_sort[l-2]
        return l1 + l2
    end
end

# Method sum_to_n?(array, n) that takes an array of integers and an additional integer, n, as arguments and 
    # returns true if any two elements in the array of integers sum to n. 
    # sum_to_n?([], n) should return false for any value of n, by definition.
def sum_to_n? arr, n
    
    if arr.length == 0
        return false
        
    elsif arr.length == 1
        return false
        
    else
        
        for i in 0..(arr.length-1)
            a=[]   
            
            for j in 0..(arr.length-1)
                
                if j != i
                    a.append(arr[j])
                end
            end
            #a2=arr-a #exclude current element
            
            if a.include? (n-arr[i])
                return true
            end
            
            a.clear()
        end
    end
    
    return false
end

# Part 2

# Method hello(name) takes a string representing a name and returns the string "Hello, "
def hello(name)
  s = "Hello, "+ name.to_s
  return s
end

# Method starts_with_consonant?(s) takes a string 
    #returns true if it starts with a consonant and 
    #returns false otherwise.
def starts_with_consonant? s
    
    if s.length == 0
        return false
    end
        
    first_letter = s[0].downcase #converting everything to lowercase firt
    
    
    if first_letter =~ /[[:alpha:]]/ # only check if first chracter is a letter
        vowels = ['a','e','i','o','u']
    
        if vowels.include? first_letter #if vowel return false
            return false
        else
            return true
        end
    
    else
        return false
    end
end

# Method binary_multiple_of_4?(s) that takes a string 
    # Returns true if the string represents a binary number that is a multiple of 4, such as '1000'. 
    # Make sure it returns false if the string is not a valid binary number
def binary_multiple_of_4? s
    
    if s.length==0
        return false
    end
    
    if s !~ /[^01]/
    
        i=s.to_i
        
        if i % 4 == 0
            return true 
        
        else
            return false
        end
    
    else
        return false
    end
end



# Part 3
class BookInStock
    
    def initialize(isbn,price)
        
        if isbn.length == 0
            raise ArgumentError
        end
        
        if price <= 0
            raise ArgumentError
        end
        
        @isbn = isbn
        @price = price
    end

    # Getters and seters
    def isbn
        @isbn
    end
    
    def price
        @price
    end
    
    def isbn=(isbn)
        @isbn = isbn
    end
    
    def price=(price)
        @price = price
    end
    
    def price_as_string
        formatted_string = "$#{'%.2f' % @price}"
 		return formatted_string
    end
	
end