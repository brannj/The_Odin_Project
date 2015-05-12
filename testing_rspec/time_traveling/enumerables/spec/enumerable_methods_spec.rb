require "enumerable_methods"

describe "Enumerable" do
  array1 = %w[a, b, c, b]
  array2 = [1, 2, 3]
  array3 = %w[cat koala bear]

  before { puts "" }

  describe "#my_each" do

    context "with array matches #each result" do

      it "passes each element to a block" do
        expect(array1.my_each { |l| l}).to eql(array1.each { |l| l})
      end
    end
  end

  describe "#my_each_with_index" do

    context "with array matches #each_with_index result" do

      it "passes each element and index to a block" do
        expect(array2.my_each_with_index { |el, i| el * i }).to eql(array2.each_with_index { |el, i| el * i })
      end
    end
  end

  describe "#my_select" do

    context "with array matches #select result" do

      it "selects the elements returned from the block" do
        expect(array2.my_select { |n| n > 1 }).to eql(array2.select { |n| n > 1 })
      end
    end
  end

  describe "#my_all?" do

    context "with array matches #all? result" do

      it "returns true if all elements pass given block" do
        expect(array2.my_all? { |n| n.is_a?(Integer) }).to eql(array2.all? { |n| n.is_a?(Integer) })
      end
    end
  end

  describe "#my_any?" do

    context "with array matches #any? result" do

      it "returns true if any element passes the given block" do
        expect(array1.my_any? { |l| l == "b" }).to eql(array1.any? { |l| l == "b" })
      end
    end
  end

  describe "#my_none?" do

    context "with array matches #none? result" do

      it "returns true if no elements pass the given block" do
        expect(array2.my_none? { |n| n > 10 }).to eql(array2.none? { |n| n > 10 })
      end
    end
  end

  describe "#my_count" do

    context "with array matches #count result" do

      it "counts elements" do
        expect(array2.my_count).to eql(array2.count)
      end

      it "counts items matching an argument" do
        expect(array1.my_count("b")).to eql(array1.count("b"))
      end

      it "counts elements yielding true from a given block" do
        expect(array2.my_count{ |n| n % 2 == 0 }).to eql(array2.count{ |n| n % 2 == 0})
      end
    end
  end

  describe "#my_map" do

    context "with array matches #map result" do

      it "returns a new array with the result of the block for each element" do
        expect(array2.my_map { |n| n * n }).to eql(array2.map { |n| n * n })
      end
    end
  end

  describe "#my_inject" do

    context "with array matches #inject result" do

      it "sums numbers using a given block" do
        expect(array2.my_inject { |sum, n| sum + n }).to eql(array2.inject { |sum, n| sum + n })
      end

      it "multiplies numbers using a given block" do
        expect(array2.my_inject { |sum, n| sum * n }).to eql(array2.inject { |sum, n| sum * n })
      end

      it "finds the longest word" do
        expect(array3.my_inject { |longest, word| longest.length > word.length ? longest : word }).to eql(array3.inject { |longest, word| longest.length > word.length ? longest : word })
      end
    end
  end
end
