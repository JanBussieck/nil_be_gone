# NilBeGone

Nil be gone provides an `Optional` monad to be used instead of explicit null checks or global monkey patched abominations such as `try`. Monads are sometimes described as "programmable semicolons" meaning that they allow you to perform some standard operation while chaining operations. For instance unwrap or flatten an array of input values, or perform nil checks before passing the result of one operation to the next, this is what this monad does.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nil_be_gone'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nil_be_gone

## Usage

Say you are given an instance of a student object and you want to find out the ranking of their university town.
You might define a method such as this:

```ruby
def town_ranking_for(student)
  unless student.nil?
    university = student.university

    unless university.nil?
      uni_town = university.uni_town

      unless uni_town.nil?
        ranking = uni_town.ranking

      end
    end
  end
end
```

Nil checks are a pervasive code smell in many ruby projects, nil_be_gone's Optional type expresses this fact that values can either be Just that value or Nothing, it's implementation of bind is `and_then` which allows you to chain operations on `Optional` types, it's `return` methods which retrieves the value from Optional is `value` and the `unit` operation which wraps an object in the monad is defined by `self.from_value`, so the above code would look like this:

```ruby
def town_ranking_for(student)
  Optional.new(student).and_then { |student|
    student.university }.and_then { |university|
    university.uni_town }.and_then { |uni_town|
    uni_town.ranking}.value
end
```

`Optional` implements method missing such that any method call s served in an `and_then` block and automatically forwarded to the value (if it is not nil), so the above code reduces to:

```ruby
def town_ranking_for(student)
  Optional.new(student).university.uni_town.ranking
end
```

Note that if we stipulate to take an object of type Optional as argument, we can simply chain operations and not concern ourselves with whether the return value is nil or with wrapping the argument in an `Optional` type.
This allows us to isolate this concern at the borders of our system, the **producers** of values such as database query methods simply wrap the result in an `Optional` before passing it on to the rest of the system which can confidently perform operations on it, and the eventual **consumer** of the result having to unwrap it by calling value on `Optional`. 
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nil_be_gone. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

