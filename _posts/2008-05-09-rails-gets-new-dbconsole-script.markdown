---
layout: post
title: "Rails gets new dbconsole script"
date: 2008-05-09
comments: true
categories: [Rails, Ruby]
---

I'm happy to announce that my
[db_console plugin](http://www.sanityinc.com/articles/rails-db-console)
for Rails has just been
[added to Rails Core](http://github.com/rails/rails/commit/2561732a08ae97fa44706a8eca4db147c4a7c286).

<!-- more -->

Instead of using `rake db:console` and friends, users of
Edge Rails (and maybe even Rails 2.1, when that's released) can enjoy
being able to conveniently launch `mysql`, `psql` or `sqlite` against
their Rails databases using `script/dbconsole`, a database
counterpart to the handy `script/console`:

```
% script/dbconsole     # connect to development database (or $RAILS_ENV)
% script/dbconsole production    # connect to production database
```

Enjoy!
