require "./spec_helper"

private alias Ti = Terminfo

private def new_dummy
  ti = Ti::Database.new_empty
  ti.set Ti::Keys::Booleans::XonXoff, true
  ti.set Ti::Keys::Booleans::HardCursor, false
  ti.set Ti::Keys::Numbers::Lines, 42_i16
  ti.set Ti::Keys::Strings::CursorHome, "\x00\x01\x02".to_slice # use Bytes[0, 1, 2] when #5354 is merged
  ti
end

describe Terminfo::Database do
  describe "#new_empty" do
    it "creates an empty db" do
      ti = Ti::Database.new_empty
      ti.names.size.should eq 0
      ti.booleans.size.should eq 0
      ti.numbers.size.should eq 0
      ti.strings.size.should eq 0
    end
  end

  describe "#new" do
    it "creates a db with given infos" do
      names = ["Foobar"]
      booleans = {Ti::Keys::Booleans::XonXoff => true}
      numbers = {Ti::Keys::Numbers::Lines => 42_i16}
      strings = {Ti::Keys::Strings::CursorHome => Bytes[0, 1, 2]}

      ti = Ti::Database.new names, booleans, numbers, strings
      ti.names.should eq names
      ti.booleans.should eq booleans
      ti.numbers.should eq numbers
      ti.strings.should eq strings
    end
  end

  describe "#set" do
    it "sets a boolean value" do
      ti = Ti::Database.new_empty

      ti.set Ti::Keys::Booleans::XonXoff, true
      ti.booleans[Ti::Keys::Booleans::XonXoff].should be_true

      ti.set Ti::Keys::Booleans::HardCursor, false
      ti.booleans[Ti::Keys::Booleans::HardCursor].should be_false

      ti.booleans.size.should eq 2
    end

    it "sets a numeric value" do
      ti = Ti::Database.new_empty

      ti.set Ti::Keys::Numbers::Lines, 42_i16
      ti.numbers[Ti::Keys::Numbers::Lines].should eq 42_i16

      ti.numbers.size.should eq 1
    end

    it "sets a string value" do
      ti = Ti::Database.new_empty

      ti.set Ti::Keys::Strings::CursorHome, Bytes[0, 1, 2]
      ti.strings[Ti::Keys::Strings::CursorHome].should eq Bytes[0, 1, 2]

      ti.strings.size.should eq 1
    end
  end

  describe "get?" do
    it "gets a valid value" do
      ti = new_dummy
      ti.get?(Ti::Keys::Booleans::XonXoff).should eq true
      ti.get?(Ti::Keys::Numbers::Lines).should eq 42_i16
      ti.get?(Ti::Keys::Strings::CursorHome).should eq Bytes[0, 1, 2]
    end

    it "gets nil for an unset value" do
      ti = new_dummy
      ti.get?(Ti::Keys::Booleans::AutoLeftMargin).should be_nil
      ti.get?(Ti::Keys::Numbers::Columns).should be_nil
      ti.get?(Ti::Keys::Strings::CursorUp).should be_nil
    end

    it "gets nil for an invalid value" do
      ti = new_dummy
      ti.get?(Ti::Keys::Booleans.new(9999)).should be_nil
      ti.get?(Ti::Keys::Numbers.new(9999)).should be_nil
      ti.get?(Ti::Keys::Strings.new(9999)).should be_nil
    end
  end

  describe "get!" do
    it "gets a valid value" do
      ti = new_dummy
      ti.get!(Ti::Keys::Booleans::XonXoff).should eq true
      ti.get!(Ti::Keys::Numbers::Lines).should eq 42_i16
      ti.get!(Ti::Keys::Strings::CursorHome).should eq Bytes[0, 1, 2]
    end

    it "raises for an unset or invalid value" do
      ti = new_dummy
      expect_raises(Ti::InvalidKeyError) { ti.get!(Ti::Keys::Booleans::AutoLeftMargin) }
      expect_raises(Ti::InvalidKeyError) { ti.get!(Ti::Keys::Numbers::Columns) }
      expect_raises(Ti::InvalidKeyError) { ti.get!(Ti::Keys::Strings::CursorUp) }

      expect_raises(Ti::InvalidKeyError) { ti.get!(Ti::Keys::Booleans.new(9999)) }
      expect_raises(Ti::InvalidKeyError) { ti.get!(Ti::Keys::Numbers.new(9999)) }
      ex = expect_raises(Ti::InvalidKeyError) { ti.get!(Ti::Keys::Strings.new(9999)) }

      ex.key.should eq Ti::Keys::Strings.new(9999)
    end
  end
end
