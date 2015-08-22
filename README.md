# Kanren

This library provides an example Ruby implementation of [μKanren](http://webyrd.net/scheme-2013/papers/HemannMuKanren2013.pdf), along with some simple data structures and relations. It is intended to accompany the article [“Hello, declarative world”](http://codon.com/hello-declarative-world).

That article explains the details, but here’s a brief demonstration:

```irb
$ irb -Ilib
>> require 'kanren/micro'
=> true
>> include Kanren::Micro
=> Object

>> goal = Goal.with_variables { |x, y|
     Goal.either(Goal.equal(x, 1), Goal.equal(y, 2))
   }
=> #<Kanren::Micro::Goal …>
>> states = goal.pursue_in(State.new)
=> #<Enumerator: …>
>> states.next.values
=> {x=>1}
>> states.next.values
=> {y=>2}
>> states.next.values
StopIteration: iteration reached an end

>> include Kanren
=> Object

>> goal = Goal.with_variables { |x|
     Relations.multiply(Peano.from_integer(3), Peano.from_integer(4), x)
   }
=> #<Kanren::Micro::Goal …>
>> states = goal.pursue_in(State.new)
=> #<Enumerator: …>
>> Peano.to_integer(states.next.result)
=> 12

>> goal = Goal.with_variables { |x, y|
     Relations.add(x, y, Peano.from_integer(8))
   }
=> #<Kanren::Micro::Goal …>
>> states = goal.pursue_in(State.new)
=> #<Enumerator: …>
>> states.each do |state|
     p state.results(2).map { |peano| Peano.to_integer(peano) }
   end
[0, 8]
[1, 7]
[2, 6]
[3, 5]
[4, 4]
[5, 3]
[6, 2]
[7, 1]
[8, 0]
=> nil
```

If you have any questions, please get in touch via [Twitter](http://twitter.com/tomstuart) or [email](mailto:tom@codon.com). If you find any bugs or other problems with the code, please [open an issue](https://github.com/tomstuart/kanren/issues/new).
