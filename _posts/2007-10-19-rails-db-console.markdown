---
layout: post
title: "Rails plugin for console database access"
date: 2007-10-19
comments: true
categories: [Rails, Ruby, Databases, PostgreSQL]
---

Ever tried using 'psql' or 'mysql' on the command-line to connect to your Rails database, only to find you forgot how to specify all those '-u' and '-h' parameters?

This plugin provides handy rake tasks for running DB console programs for the various databases in your database.yml.  It supports postgresql, mysql, sqlite and sqlite3 connections.

<!-- more -->

I've been using this trick myself for over 2 years now, but I've only just got around to packaging it up as a plugin.

### Examples

```bash
% rake db:console                  # Connect to your RAILS_ENV database
% rake db:console:production       # Connect to the production database
% rake db:console:test             # Connect to the test database
% rake db:console:some_other_db    # Connect to some_other_db defined in database.yml
% RAILS_ENV=test rake db:console   # Connect to the test database
```

### Getting it

You can use `script/plugin` to install the plugin:

```bash
% script/plugin install https://rails.sanityinc.com/plugins/db_console/
```

Alternatively, you can download a snapshot from the plugin's
[git repository](https://github.com/purcell/db_console) instead (tip:
that page has an RSS feed for tracking check-ins). Unpack the snapshot
tarball under your `RAILS_ROOT/vendor/plugins` directory.

**Update: Edge Rails, as of early May 2008,
[has `script/dbconsole` instead](/articles/rails-gets-new-dbconsole-script),
which was derived from the code of this plugin**

### Feedback and contributions welcome

Not working for you? Want to add support for other database console programs?  Get in touch!

*If you haven't already, why not
[subscribe to this site's feed](/rss.xml) to
get the latest news about this plugin and other Rails goodies?*

