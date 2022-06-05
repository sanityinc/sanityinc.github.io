---
layout: post
title: "Renumber clashing Rails migrations in one easy step"
date: 2007-11-19
comments: true
categories: [Plugins, Rails, Subversion]
---

If you work in a team on a Rails project, chances are that you and
your team mates occasionally create identically-numbered migrations.
Renumbering a migration that you're working on is a pain, unless
you're using this handy `renumber_migrations` plugin.

<!-- more -->

<h3>Scenario</h3>

You're working on migration `045_add_my_new_feature.rb`, when one of your team-mates checks `045_some_other_migration.rb` into `svn`.  You notice the numbering clash (or `rake db:migrate` notices it for you), and you simply run the `db:migrate:renumber` task:

```bash
% rake db:migrate:renumber
```

Voilá - your migration is renumbered to `046`, and the database schema
is left at version `044` ready for you to re-test your migration.  (If
you had multiple new migrations, all of them would get renumbered.)

### Requirements and assumptions

To be able to use this plugin, you must:

1.  Be using subversion for your version control
2.  Have a working `#down` method for each local clashing migration
3.  Have network access to the subversion server, since clashing
    migrations are temporarily removed locally, and later re-requested.


### Getting it

You can use `script/plugin` to install the plugin:

```bash
% script/plugin install https://rails.sanityinc.com/plugins/renumber_migrations/
```

Alternatively, you can download a snapshot from the plugin's
[git repository](https://github.com/purcell/renumber_migrations)
instead (tip: that page has an RSS feed for tracking
check-ins). Unpack the snapshot tarball under your
`RAILS_ROOT/vendor/plugins` directory.

### More

If you like the look of this plugin, why not
[subscribe to my feed](/rss.xml)?
