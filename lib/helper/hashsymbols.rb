module HashSymbols
  refine Hash do
    def to_sym_keys
       deep_transform_keys{ |key| key.to_sym rescue key }
    end

    def to_sym_keys!
      self.replace(deep_transform_keys{ |key| key.to_sym rescue key })
    end

    def deep_transform_keys(&block)
      result = {}
      each do |key, value|
        result[yield(key)] = value.is_a?(Hash) ? value.deep_transform_keys(&block) : value
      end
      result
    end
  end
end

using HashSymbols

if __FILE__ == $0 
  hash = {"hoge1" => "test", "hoge2" => "test2", "hoge" => "test3"}
  hash_sym = hash.to_sym_keys
  hash.to_sym_keys!
  
  puts hash_sym
  puts hash
end
