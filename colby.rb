require 'hamster'

class IndexOutOfBounds < Exception; end

module Colby
  module Core
    def Core.hash_map *pairs
      return Hamster.hash(Hash[*pairs]) if pairs.is_a? Array
      return Hamster.hash(*pairs) if pairs.is_a? Hash
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
    def Core.nth coll, key
      return Core.get coll, key if coll.is_a? Hamster::Vector
      return coll.to_a[key] if coll.is_a? Hamster::List
    end
    def Core.find coll, key
      return Core.vec(key, Core.get(coll, key)) if coll.is_a? Hamster::Vector
      return Core.vec(key, Core.get(coll,key)) if coll.is_a? Hamster::Hash
    end
    def Core.has_key coll, key
      return coll.has_key? key if coll.is_a? Hamster::Hash
      return coll[key] != nil if coll.is_a? Hamster::Vector or coll.is_a? Hamster::Set
      nil
    end
    def Core.count coll
      return coll.length
    end
    def Core.peek coll
      return coll.head if coll.is_a? Hamster::List
      return coll.last if coll.is_a? Hamster::Vector
    end
    def Core.pop coll
      return coll.tail if coll.is_a? Hamster::List
      if coll.is_a? Hamster::Vector
        return Core.vec(*coll.to_a[0..-2])
      end
    end
    def Core.zip_map coll1, coll2
      return Core.hash_map(Hash[coll1.to_a.zip(coll2.to_a)])
    end

    def Core.seq data
      if data.is_a? Hamster::List
        return data
      elsif data.is_a? Array or data.is_a? Hamster::Vector
        return Core.list *data
      elsif data.is_a? Hash
        return Core.list *data.keys.to_a.zip(data.values.to_a)
      elsif data.is_a? Hamster::Hash
        l = Core.list; data.foreach {|k,v| l = Core.conj(l,(Core.list k, v))}
        return l.flatten if l.count == 1
        return l if l.count > 1
      elsif data.is_a? Hamster::Set
        return (Core.list *data).sort
      elsif data.is_a? String
        return Core.list *data.split("")
      else
        raise Exception
      end
    end
  end
end