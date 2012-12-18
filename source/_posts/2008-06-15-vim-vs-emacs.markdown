---
layout: post
title: "On vim vs Emacs"
date: 2008-06-15
comments: true
categories: [Emacs, Vim, Unix]
---

I often hear the proponents of [vim](http://www.vim.org/) and
[emacs](http://www.gnu.org/software/emacs/) discussing which is
better, usually pitting emacs' extensibility against vi's archaic yet
arguably effective and tendon-friendly scheme of editing modes.

But why choose?

<!-- more -->

I love the "vi way". I was a die-hard vim user until I realised that,
with [some](http://www.emacswiki.org/cgi-bin/wiki/ViperMode)
[customisation](http://www.emacswiki.org/cgi-bin/wiki/vimpulse.el),
**emacs can *be* vim**. After all, many advanced vim users end up
working with multiple windows, and keeping their vims running for an
extended period, which is exactly what emacs users do.

So for 8 or 9 years now, I've been a happy emacs user, working with vi
key bindings all day long, while picking and choosing from emacs' vast
library of useful extensions. I've got a
[highly customised](http://git.sanityinc.com/?p=emacs.d.git;a=summary)
emacs, learned some emacs-lisp, and yet I don't even know the emacs
key bindings for mark/copy/paste. And when I'm working in a shell, I
can (and do) drop into vim and still feel completely at home.

Curious vim users can get started by firing up emacs, hitting `meta-x`,
and entering `viper-mode`. That's built into every emacs you're likely
to encounter. To get vim-specific features such as `control-n`/`p`
expansion, window splitting, and rectangular selections, follow the
instructions that
[come with vimpulse](http://www.emacswiki.org/cgi-bin/wiki/vimpulse.el).
