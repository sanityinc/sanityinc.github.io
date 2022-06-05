---
layout: post
title: "Adding Array#to_proc to Ruby"
date: 2009-04-14
comments: true
categories: [Ruby]
---

Here's a neat Ruby trick for fans of `Symbol#to_proc`.

<!-- more -->

This magical method, introduced by both Rails and Ruby 1.9, lets you do things like this:

```ruby
> %w(1 2 3 4 5).map &:to_i
=> [1, 2, 3, 4, 5]
```

And that proc can, of course, take multiple parameters:

```ruby
[1,2,3,4].zip([2,3,4,5])
=> [[1, 2], [2, 3], [3, 4], [4, 5]]> [1,2,3,4].zip([2,3,4,5]).map &:sum
=> [3, 5, 7, 9]
```

However, if you want to "close" a value into the proc, you're out of
luck, so you have to define a block old-school-style:

```ruby
> %w(kung ruby bar).map { |e| e + "-fu" }
=> ["kung-fu", "ruby-fu", "bar-fu"]
```

But check out the following little hack:

```ruby
class Array
  def to_proc
    lambda { |target| target.send(*self) }
  end
end
```

Now look what you can do:

```ruby
> %w(kung ruby bar).map &[:+, "-fu"]
=> ["kung-fu", "ruby-fu", "bar-fu"]
```

What do you think? Handy? Disgusting? Leave a comment to let me know!

*Update: apparently others have had
[similar](https://rails.lighthouseapp.com/projects/8994/tickets/1253-arrayto_proc)
[ideas](https://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/199820),
but with different semantics. So perhaps this trick is a little too
opaque...*
