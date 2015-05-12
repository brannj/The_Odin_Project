def caesar_cipher(text, shift_factor)
  cipher = ""
  # Handle negative factors and factors greater than 26.
  shift_factor %= 26
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
  cipher
end

# puts caesar_cipher("Refactor", 26)
