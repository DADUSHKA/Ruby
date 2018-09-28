hash = {}
letters =['a', 'e', 'i', 'o', 'u', 'y']
array = ("a".."z").to_a.zip((1..26).to_a)

array.each do |arr|
if arr[0] == letters[0]

 hash[arr[0]] = arr[1]

end

letters.delete(arr[0])

end

print hash
