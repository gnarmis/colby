# Colby

A small wrapper and functions to make working with persistent, immutable data
structures easy.

- This project depends on [Hamster](https://github.com/harukizaemon/hamster)
- [Mori](http://swannodette.github.com/mori/) is a source of ideas for this library

## Testing

- `rspec .`

## Installation

`gem install colby`

or

`gem build ./colby.gemspec`
`gem install --local ./colby-x.x.x.gem`

## Usage

```ruby
require 'colby'

include Colby::Core

# Now you can build hash_map, vec, list, or set

# Also, you have clojure-like functions such as assoc, get, conj, has_key

# check the spec to see examples

```
