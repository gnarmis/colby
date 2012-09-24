require './colby.rb'

describe "All specs" do

  before :each do
    @c = Colby::Core
  end

  describe "Basic specs" do
    it "should construct hash-maps given a Ruby Hash" do
      @c.hash_map(:a => 1).should == Hamster.hash(:a => 1)
    end
    it "should construct vectors given values" do
      @c.vec(1,2,3).should == Hamster.vector(1,2,3)
    end
    it "should construct lists given values" do
      @c.list(1,2,3).should == Hamster.list(1,2,3)
    end
    it "should construct sets given values" do
      @c.set(1,2,3,3).should == Hamster.set(1,2,3,3)
    end
  end

  describe "Core functions" do
    it "should conj items to head of list" do
      @c.conj(@c.list(1,2,3), 0).should == @c.list(0,1,2,3)
    end
    it "should conj items to end of vector" do
      @c.conj(@c.vec(1,2,3), 0).should == @c.vec(1,2,3,0)
    end
    it "should conj hash_maps by merging them" do
      @c.conj(@c.hash_map(:a=>1), 
        @c.hash_map(:b=>2,:c=>3)).should == @c.hash_map(:a=>1,:b=>2,:c=>3) 
    end
    it "should assoc new key-value pairs when conj'ing hash_maps" do
      @c.conj(@c.hash_map(:a=>1), 
        @c.hash_map(:a=>2,:c=>3)).should == @c.hash_map(:a=>2,:c=>3) 
    end
    it "should conj sets by making a bigger set" do
      @c.conj(@c.set(1,2,3,3), 4).should == @c.set(1,2,3,4)
    end

    it "should assoc any number of pairs into a hash_map collection" do
      @c.assoc(@c.hash_map(:a=>1), 
                :a, 2, 
                :b, 3, 
                :c, 4).should == @c.hash_map(:a=>2,
                                             :b=>3,
                                             :c=>4)
    end
    it "should assoc index-bounded pairs into a vector collection" do
      @c.assoc(@c.vec(1,2,3),0,4,1,5,2,6).should == @c.vec(4,5,6)
    end
    it "should raise an exception if unbounded pairs used to assoc into a vec" do
      expect {@c.assoc(@c.vec(1,2),9,9)}.to raise_error
    end

    it "should return value when using get with a hash_map" do
      @c.get( @c.hash_map(:a=>1), :a).should == 1
    end
    it "should return value when using get with a vector" do
      @c.get( @c.vec(1,2), 0).should == 1
    end

    it "should return bool if vec has or doesn't have key" do
      @c.has_key(@c.vec(1,2), 0).should == true
      @c.has_key(@c.vec(1,2), 3).should == false
    end
    it "should return bool if hash_map has or doesn't have key" do
      @c.has_key(@c.hash_map(:a=>1), :a).should == true
      @c.has_key(@c.hash_map(:a=>1), 3).should == false
    end
  end

end