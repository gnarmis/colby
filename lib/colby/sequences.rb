require 'hamster'

module Colby
   module Core

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
