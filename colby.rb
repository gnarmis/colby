require 'hamster'

# other kinds of randomness
# def define name, value; Object.send(:define_method, name) { value }; end
# (define :a, 1) #=> a gets associated with a lambda

class IndexOutOfBounds < Exception; end

module Colby
  module Core
    def Core.hash_map data
      Hamster.hash data
    end
    def Core.vec *data
      Hamster.vector *data
    end
    def Core.list *data
      Hamster.list *data
    end
    def Core.set *data
      Hamster.set *data
    end
    def Core.conj coll, item
      return coll.cons item if coll.is_a? Hamster::List
      return coll.add item if coll.is_a? Hamster::Vector
      return coll.merge item if coll.is_a? Hamster::Hash
      return Hamster.set *coll, item if coll.is_a? Hamster::Set
    end
    def Core.assoc coll, *pairs
      @retval = coll
      pairs.each_slice(2) do |k,v|
        @retval = Core.assoc_2 @retval, k , v
      end
      @retval
    end
    def Core.assoc_2 coll, key, val
      if coll.is_a? Hamster::Hash
        return coll.send(:put, key) {val}
      end
      if coll.is_a? Hamster::Vector
        if Core.has_key coll, key
          return coll.send(:set, key, val)
        else
          raise IndexOutOfBounds
        end
      end
    end
    def Core.get coll, key
      coll.get key unless coll.is_a? Hamster::List
    end
    def Core.has_key coll, key
      return coll.has_key? key if coll.is_a? Hamster::Hash
      return coll[key] != nil if coll.is_a? Hamster::Vector or coll.is_a? Hamster::Set
      nil
    end
  end
end