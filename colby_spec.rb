require './colby.rb'

include Colby::Core

describe "All specs" do

  describe "Basic specs" do
    it "should construct hash-maps given a Ruby Hash" do
      hash_map(:a => 1).should == Hamster.hash(:a => 1)
    end
    it "should construct vectors given values" do
      vec(1,2,3).should == Hamster.vector(1,2,3)
    end
    it "should construct lists given values" do
      list(1,2,3).should == Hamster.list(1,2,3)
    end
    it "should construct sets given values" do
      set(1,2,3,3).should == Hamster.set(1,2,3,3)
    end
  end

  describe "Core functions" do
    it "should conj items to head of list" do
      conj(list(1,2,3), 0).should == list(0,1,2,3)
    end
    it "should conj items to end of vector" do
      conj(vec(1,2,3), 0).should == vec(1,2,3,0)
    end
    it "should conj hash_maps by merging them" do
      conj(hash_map(:a=>1), 
        hash_map(:b=>2,:c=>3)).should == hash_map(:a=>1,:b=>2,:c=>3) 
    end
    it "should assoc new key-value pairs when conj'ing hash_maps" do
      conj(hash_map(:a=>1), 
        hash_map(:a=>2,:c=>3)).should == hash_map(:a=>2,:c=>3) 
    end
    it "should conj sets by making a bigger set" do
      conj(set(1,2,3,3), 4).should == set(1,2,3,4)
    end


    it "should assoc any number of pairs into a hash_map collection" do
      assoc(hash_map(:a=>1), 
                :a, 2, 
                :b, 3, 
                :c, 4).should == hash_map(:a=>2,
                                             :b=>3,
                                             :c=>4)
    end
    it "should assoc index-bounded pairs into a vector collection" do
      assoc(vec(1,2,3),0,4,1,5,2,6).should == vec(4,5,6)
    end
    it "should raise an exception if unbounded pairs used to assoc into a vec" do
      expect {assoc(vec(1,2),9,9)}.to raise_error
    end


    it "should return value when using get with a hash_map" do
      get( hash_map(:a=>1), :a).should == 1
    end
    it "should return value when using get with a vector" do
      get( vec(1,2), 0).should == 1
    end


    it "should return value when using nth with a vec" do
      nth(vec(1,2,3), 0).should == 1
    end
    it "should return value when using nth with a list" do
      nth(list(1,2,3), 0).should == 1
    end
    it "should not return value when using nth with a set" do
      nth(set(1,2,3), 0).should_not == 1
    end
    it "should not return value when using nth with a hash_map" do
      nth(hash_map(1,2,3,4), 1).should_not == 2
    end



    it "should return key/val pair as a vector for a vector" do
      find(vec(1,2),0).should == vec(0,1)
    end
    it "should return key/val pair as a vector for a hash_map" do
      find(hash_map(1,2,3,4), 3).should == vec(3,4)
    end


    it "should return bool if vec has or doesn't have key" do
      has_key(vec(1,2), 0).should == true
      has_key(vec(1,2), 3).should == false
    end
    it "should return bool if hash_map has or doesn't have key" do
      has_key(hash_map(:a=>1), :a).should == true
      has_key(hash_map(:a=>1), 3).should == false
    end


    it "should return count for lists" do
      count(list(1,2,3)).should == 3
    end
    it "should return count for vectors" do
      count(vec(1,2,3)).should == 3
    end
    it "should return count for sets" do
      count(set(1,2,3)).should == 3
    end
    it "should return count for hash_maps" do
      count(hash_map(1=>2,3=>4)).should == 2
    end


    it "should return head of list when using peek" do
      peek(list(1,2,3)).should == 1
    end
    it "should return last element of vec when using peek" do
      peek(vec(1,2,3)).should == 3
    end


    it "should return list with head removed when using pop" do
      pop(list(1,2,3)).should == list(2,3)
    end
    it "should return vec with last item removed when using pop" do
      pop(vec(1,2,3)).should == vec(1,2)
    end


    it "should zip two seqs into a hash_map" do
      zip_map(vec(1,2,3), list(4,5,6)).should == hash_map(1,4,2,5,3,6)
    end


    it "should convert Arrays, lists, and vecs into a seq (list)" do
      seq([1,2,4,3]).should == list(1,2,4,3)
      seq(list(1,2,4,3)).should == list(1,2,4,3)
      seq(vec(1,2,4,3)).should == list(1,2,4,3)
    end
    it "should convert a Hash into a seq" do
      seq(hash_map(:a,2)).should == list(list(:a,2))
    end
    it "should convert a String into a seq" do
      seq("abc").should == list("a","b","c")
    end
  end

end
