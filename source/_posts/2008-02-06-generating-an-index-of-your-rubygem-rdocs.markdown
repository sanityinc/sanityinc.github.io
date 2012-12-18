---
layout: post
title: "Generate an HTML index of your ruby gem rdocs"
date: 2008-02-06
comments: true
categories: [Ruby]
---

Rubygems is kind enough to generate RDoc for installed gems, but the
directories move as the gem versions evolve, and it's inconvenient to
keep browsing for them.  This tool produces a useful HTML index with
direct links to the RDocs for all the gems installed on your system.

<!-- more -->
![Example Gem RDoc index page](/images/gem-rdoc-index-example_0.png)

### Getting it

The program's git repository is here:
[gemdocindex](http://git.sanityinc.com/?p=gemdocindex.git;a=summary).

Either browse to 'gemdocindex' there and [download the raw
version](http://git.sanityinc.com/?p=gemdocindex.git;a=blob_plain;f=gemdocindex;hb=master),
or check out ("clone") the repository as follows:

```bash
git clone git://git.sanityinc.com/gemdocindex.git
```

You can then track
future changes by executing this command in the 'gemdocindex' directory:

```bash
git pull
```

### Running it

Execute this command from a UNIX command line:

```bash
./gemdocindex > gemindex.html
```

(Windows users can probably run the same command, adding "ruby" at the beginning.)

Tested on OS X; should work on other platforms. Patches are welcome.

### Further information

If you found this helpful, you can
[subscribe](http://www.sanityinc.com/rss.xml) to get more articles about
Rails and Ruby-related topics and tools.
