---
layout: post
title: "Swimming in code: recent hacks"
date: 2010-09-05
comments: true
categories: [Emacs, github, javascript, lisp, python, Ruby]
---

Recently I've been on a hacking high, touching a lot of code, and in
touch with a lot of cool programmers. In retrospect I'm surprised at
the variety of stuff I've been doing, so I thought I'd write a short
list.
<!-- more -->
### Open source

#### Javascript

- I added support for Twitter's "lists" to
    [seaofclouds' tweet.js widget](http://tweet.seaofclouds.com/): see
    my [clone on github](http://github.com/purcell/tweet). You can see
    it in action at the bottom of
    [this page](http://www.looktothestars.org/).

#### Clojure

- Congomongo - Clojure's de-facto standard library for accessing
    [MongoDB](http://www.mongodb.org/) - had no support for MongoDB's
    file
    [GridFS](http://www.mongodb.org/display/DOCS/GridFS+Specification)
    file storage scheme, so I
    [added it](http://github.com/purcell/congomongo).
- When I've only had a few spare minutes, I've been
    [filling in a few missing Clojure examples on Rosettacode](http://github.com/purcell/rosettacode-clojure). It's
    a great way to share knowledge, learn new libraries and
    algorithms, and solve puzzles.
- I've contributed minor patches to
    [Leiningen](http://github.com/technomancy/leiningen), the Clojure
    build tool.

#### Ruby

- Accepted some patches for my
    [darcs-to-git](http://github.com/purcell/darcs-to-git) repository
    conversion script. (See
    [my original article about this](http://www.sanityinc.com/articles/converting-darcs-repositories-to-git).)

#### Python

- I've agreed to review (but not write) the unit-testing chapter of
    the PSF's planned Python book. Although I
    [wrote the unittest module](http://pyunit.sf.net), I'm no longer
    an active Python user or member of the community.

#### Emacs lisp

- My haml-mode patch for colorizing "filter:" blocks in haml files has
    been
    [committed upstream](http://github.com/nex3/haml/commit/94a8228e),
    so now textile, markdown, javascript and ruby portions of these
    files are font-locked correctly.
- Naturally, while I've been doing all this diverse hacking, I've been
    [tweaking my emacs config quite heavily](http://github.com/purcell/emacs.d/commits/master).

#### Misc

- As I recently blogged, I
    [customised emacs-handler](http://www.sanityinc.com/articles/open-txmt-urls-from-rails-in-emacs-on-osx)
    and have played with
    [full-screen support for Cocoa Emacs](http://www.sanityinc.com/full-screen-support-for-cocoa-emacs-on-osx).

### Closed-source

I have two main closed-source projects on my plate. The first, our
[site about celebrities and the charities they support](http://www.looktothestars.org),
has seen me doing a bunch of Twitter API hacking recently. The second
project, currently Top Secret, is a Clojure data-oriented website,
using MongoDB and fun stuff like geocoding and data mining.

### Thoughts

The programming ecosphere is more diverse than ever, and there are more
powerful tools available to programmers than ever before. It's thrilling
to be involved with this, and to aid in the cross-pollination of tricks,
skills and idioms between unrelated projects. As a work-from-home
entrepreneur, collaborating remotely on open (and closed) source
projects with interesting people is a surprisingly good proxy for having
real officemates.
