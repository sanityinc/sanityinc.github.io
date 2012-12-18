---
layout: post
title: "Full-screen support for Cocoa Emacs on OS X"
date: 2010-01-31
comments: true
categories: [Emacs, Mac, OSX]
---

Prolific Japanese hacker Daisuke Murase (a.k.a. <a href="http://github.com/typester">typester</a>) has recently patched Cocoa Emacs to add a full-screen display mode. Here's how to add this must-have feature into your own local Emacs tree while you wait for it to get integrated into the official Emacs sources.

<!-- more -->

Let's start with the assumptions that using the latest dev version of Emacs is a Good Thing, and that full-screen display is a feature so wonderful (particularly on laptops) that it's worth some small effort to obtain.

I build my Emacs from a local copy of the official <a href="http://repo.or.cz/r/emacs.git">Emacs git repo</a>, which is automatically updated from the master bzr tree. Just a "git pull", and I'm up to date.

I don't want to build from typester's repo because it hasn't been updated from upstream since December.

So I add typester's repo as an additional remote:

```
$ git remote add typester git://github.com/typester/emacs.git
$ git fetch typester
```

However, I find that his feature branch doesn't merge cleanly with the official clone, perhaps because he started with a different git clone of the emacs sources.

Looking at the history of typester's branch, the last upstream change was a3585f6c2a. So, to apply the changes he made on my current branch:

```
$ git diff a3585f6c2a typester/feature/fullscreen | patch -p1
```

And I see it applies without any conflicts! Great! (Here's <a href="http://gist.github.com/291150">a copy of the patch as it looks today</a>.)

Now I can build as usual:

```
$ ./configure --with-ns
$ make && make install
$ mv nextstep/Emacs.app /Applications/
```

To toggle full-screen mode inside emacs:

```
M-x ns-toggle-fullscreen
```
