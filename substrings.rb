# Substrings Task - The Odin Project

=begin
Task: Take sentence (string) and array of words,
      return hash containing words that occur in the
      string (key) and number of occurences (value).

Method: Uses #scan to find occurences.

=end

def substrings(sentence, words)
  substrings = {}
  words.each do |word|
    instances = sentence.downcase.scan(word)
    substrings[word] = instances.size if instances.size > 0
  end
  puts substrings
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

substrings("Howdy partner, sit down! How's it going?", dictionary)
