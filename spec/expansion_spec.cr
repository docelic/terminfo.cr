require "./spec_helper"

private def expand(param_str, *args)
  expander = Terminfo::Expansion::Expander.new
  expander.expand param_str.to_slice, *args
end

describe Terminfo::Expansion::Expander do
  it "works for test_basic_setabf" do
    expand("\\E[48;5;%p1%dm", 1).should eq "\\E[48;5;1m"
  end

  it "works for print" do
    expand("%p1%4d", 1).should eq "0001"

    expand("%p1%o", 8).should eq "10"
  end

  it "works for conditional" do
    expand("%?%p1%t1%e2%;", 1).should eq "1"

    expand("%?%p1%t1%e2%;", 0).should eq "2"

    expand("%?%p1%t%e%p2%t2%e%p3%t3%;", 0, 0, 1).should eq "3"
  end
end
