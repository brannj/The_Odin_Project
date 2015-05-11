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
