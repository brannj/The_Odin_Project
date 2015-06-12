require 'rest-client'

print "Enter a url: "
url = gets.chomp
puts RestClient.get(url)
