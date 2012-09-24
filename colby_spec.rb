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


    it "should return value when using nth with a vec" do
      @c.nth(@c.vec(1,2,3), 0).should == 1
    end
    it "should return value when using nth with a list" do
      @c.nth(@c.list(1,2,3), 0).should == 1
    end
    it "should not return value when using nth with a set" do
      @c.nth(@c.set(1,2,3), 0).should_not == 1
    end
    it "should not return value when using nth with a hash_map" do
      @c.nth(@c.hash_map(1,2,3,4), 1).should_not == 2
    end



    it "should return key/val pair as a vector for a vector" do
      @c.find(@c.vec(1,2),0).should == @c.vec(0,1)
    end
    it "should return key/val pair as a vector for a hash_map" do
      @c.find(@c.hash_map(1,2,3,4), 3).should == @c.vec(3,4)
    end


    it "should return bool if vec has or doesn't have key" do
      @c.has_key(@c.vec(1,2), 0).should == true
      @c.has_key(@c.vec(1,2), 3).should == false
    end
    it "should return bool if hash_map has or doesn't have key" do
      @c.has_key(@c.hash_map(:a=>1), :a).should == true
      @c.has_key(@c.hash_map(:a=>1), 3).should == false
    end


    it "should return count for lists" do
      @c.count(@c.list(1,2,3)).should == 3
    end
    it "should return count for vectors" do
      @c.count(@c.vec(1,2,3)).should == 3
    end
    it "should return count for sets" do
      @c.count(@c.set(1,2,3)).should == 3
    end
    it "should return count for hash_maps" do
      @c.count(@c.hash_map(1=>2,3=>4)).should == 2
    end


    it "should return head of list when using peek" do
      @c.peek(@c.list(1,2,3)).should == 1
    end
    it "should return last element of vec when using peek" do
      @c.peek(@c.vec(1,2,3)).should == 3
    end


    it "should return list with head removed when using pop" do
      @c.pop(@c.list(1,2,3)).should == @c.list(2,3)
    end
    it "should return vec with last item removed when using pop" do
      @c.pop(@c.vec(1,2,3)).should == @c.vec(1,2)
    end


    it "should zip two seqs into a hash_map" do
      @c.zip_map(@c.vec(1,2,3), @c.list(4,5,6)).should == @c.hash_map(1,4,2,5,3,6)
    end

  end

end