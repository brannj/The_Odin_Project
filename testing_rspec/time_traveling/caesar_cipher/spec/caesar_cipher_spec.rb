require 'caesar_cipher'

describe ".ceasar_cipher" do
  it "raises error with less then two arguments" do
    expect{caesar_cipher()}.to raise_error(ArgumentError)
  end

  it "returns the same amount of characters" do
    expect(caesar_cipher("abc xyz", 1).length).to eq(7)
  end

  it "shifts to the right by the given positive factor" do
    expect(caesar_cipher("abc", 3)).to eq("def")
  end

  it "shifts to the left by the given negative factor" do
    expect(caesar_cipher("abc", -3)).to eq("xyz")
  end

  it "does not shift if factor is zero" do
    expect(caesar_cipher("No change!", 0)).to eq("No change!")
  end

  it "wraps from z to a" do
    expect(caesar_cipher("xyz", 5)).to eq("cde")
  end

  it "keeps spaces" do
    expect(caesar_cipher("Space me  out   !", 16)).to eq("Ifqsu cu  ekj   !")
  end

  it "keeps punctuaton" do
    expect(caesar_cipher("Pu, nc. tu! at/ ed?", 9)).to eq("Yd, wl. cd! jc/ nm?")
  end

  it "keeps capitalization" do
    expect(caesar_cipher("CaPiTaLiSeD", 25)).to eq("BzOhSzKhRdC")
  end

  it "handles factors larger than 26" do
    expect(caesar_cipher("Maximise", 9999999)).to eq("Vjgrvrbn")
  end

  it "returns the same string for multiples of 26" do
    expect(caesar_cipher("B-Mo", 78)).to eq("B-Mo")
  end
end
