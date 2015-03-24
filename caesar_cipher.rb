# The Odin Project.
# Projects: Building Blocks.
# Project 1: Caesar Cipher.
#
# Task: take a string, return a cipher.
#
# Method: Cycles through input text with #each_char.
#        Uses #ord to convert to ASCII decimal.
#        Checks against ASCII A..Z and a..z ranges.
#        Wraps back to A or a if goes past Z or z.
#        Uses #chr to convert to letter.

def caesar_cipher(text, shift_factor)
  cipher = ""
  text.each_char do |letter|
    cipher << case
    when (65..90).include?(letter.ord)
      if (letter.ord + shift_factor) > 90
        (64 + (shift_factor - (90 - letter.ord))).chr
      else
        (letter.ord + shift_factor).chr
      end
    when (97..122).include?(letter.ord)
      if (letter.ord + shift_factor) > 122
        (96 + (shift_factor - (122 - letter.ord))).chr
      else
        (letter.ord + shift_factor).chr
      end
    else
      letter
    end
  end
  puts cipher
end

caesar_cipher("What a string!", 5)
