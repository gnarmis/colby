require 'hamster'

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

  end
end
