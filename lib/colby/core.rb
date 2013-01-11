require 'hamster'

class IndexOutOfBounds < Exception; end

module Colby
  module Core

    def hash_map(*pairs)
      return Hamster.hash(Hash[*pairs]) if pairs.is_a? Array
      return Hamster.hash(*pairs) if pairs.is_a? Hash
    end

    def vec(*data)
      Hamster.vector(*data)
    end

    def list(*data)
      Hamster.list(*data)
    end

    def set(*data)
      Hamster.set(*data)
    end

    def conj(coll, item)
      return coll.cons(item) if coll.is_a? Hamster::List
      return coll.add(item) if coll.is_a? Hamster::Vector
      return coll.merge(item) if coll.is_a? Hamster::Hash
      return Hamster.set(*coll, item) if coll.is_a? Hamster::Set
    end

    def assoc(coll, *pairs)
      @retval = coll
      pairs.each_slice(2) do |k,v|
        @retval = assoc_2(@retval, k , v)
      end
      @retval
    end

    def assoc_2(coll, key, val)
      if coll.is_a? Hamster::Hash
        return coll.send(:put, key) {val}
      end
      if coll.is_a? Hamster::Vector
        if has_key(coll, key)
          return coll.send(:set, key, val)
        else
          raise IndexOutOfBounds
        end
      end
    end

    def get(coll, key)
      coll.get(key) unless coll.is_a? Hamster::List
    end

    def nth(coll, key)
      return get(coll, key) if coll.is_a? Hamster::Vector
      return coll.to_a[key] if coll.is_a? Hamster::List
    end

    def find(coll, key)
      return Core.vec(key, Core.get(coll, key)) if coll.is_a? Hamster::Vector
      return Core.vec(key, Core.get(coll,key)) if coll.is_a? Hamster::Hash
    end

    def has_key(coll, key)
      return coll.has_key?(key) if coll.is_a? Hamster::Hash
      return coll[key] != nil if (coll.is_a? Hamster::Vector) || (coll.is_a? Hamster::Set)
      nil
    end

    def count(coll)
      return coll.length
    end

    def peek(coll)
      return coll.head if coll.is_a? Hamster::List
      return coll.last if coll.is_a? Hamster::Vector
    end

    def pop(coll)
      return coll.tail if coll.is_a? Hamster::List
      if coll.is_a? Hamster::Vector
        return vec(*coll.to_a[0..-2])
      end
    end

    def zip_map(coll1, coll2)
      return hash_map(Hash[coll1.to_a.zip(coll2.to_a)])
    end

    def seq(data)
      if data.is_a? Hamster::List
        return data
      elsif data.is_a? Array or data.is_a? Hamster::Vector
        return list(*data)
      elsif data.is_a? Hash
        return list(*data.keys.to_a.zip(data.values.to_a))
      elsif data.is_a? Hamster::Hash
        l = list
        data.foreach {|k,v| l = conj(l,(list k, v))}
        return l
      elsif data.is_a? Hamster::Set
        return (list(*data)).sort
      elsif data.is_a? String
        return list(*data.split(""))
      else
        raise Exception
      end
    end

  end
end
