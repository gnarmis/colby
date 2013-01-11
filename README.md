# Colby

Experimenting with bringing Clojure's goodness in Ruby.

- This project depends on [Hamster](https://github.com/harukizaemon/hamster)
- The basic idea for now is to have something broadly equivalent to [Mori](http://swannodette.github.com/mori/), but in Ruby

## Testing

- `rspec .`

## Usage

- make sure you have 1.9.3-p194
- `bundle install`

```ruby
require './colby.rb'

include Colby::Core

# Now you can build hash_map, vec, list, or set

# Also, you have clojure-like functions such as assoc, get, conj, has_key

# check the spec to see examples

```
