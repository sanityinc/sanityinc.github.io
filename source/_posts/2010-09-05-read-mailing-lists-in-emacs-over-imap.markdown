---
layout: post
title: "Save hours by reading mailing lists in Emacs over IMAP"
date: 2010-09-05
comments: true
categories: [Emacs]
---

Emacs' built-in newsreader Gnus is made for efficiently keeping up
with high-volume lists; I show how to hook it into your IMAP account.

<!-- more -->

With features like configurable message threading, kill-files and
per-thread and per-poster scoring, Gnus has the potential to save a
lot of the time you would normally spend wading through high-volume
mailing lists.

Nowadays most people read mailing lists via IMAP-enabled mail
accounts, e.g. Gmail. Gnus supports IMAP directly, but it doesn't work
well when the remote folders have thousands of messages, as is the
case with many mailing lists. As a workaround, we can use [offlineimap](http://wiki.github.com/jgoerzen/offlineimap/)
to maintain a local copy of our folders. As a side benefit, we can
then read mail off-line.

We can use the excellent [Dovecot](http://www.dovecot.org/) to provide an IMAP interface to that
local copy so that Gnus can access it; and we can do this without
configuring Dovecot as a full IMAP server, which would need to run
constantly and be configured for authentication etc.

On a Mac, you can install dovecot and offlineimap with [Homebrew](http://github.com/mxcl/homebrew),
MacPorts or, presumably, Fink.

In `~/.dovecotrc`:

```
protocols = imap
mail_location = maildir:~/Library/Caches/OfflineImap
auth default {
}
```

And in `~/.offlineimaprc`:

```ini
[general]
accounts = Mail
maxsyncaccounts = 1
ui = TTY.TTYUI
[Account Mail]
localrepository = Local
remoterepository = Remote
[Repository Local]
type = IMAP
preauthtunnel = dovecot -c ~/.dovecotrc --exec-mail imap
[Repository Remote]
type = IMAP
# or "type = Gmail", if applicable
remotehost = my.mail.server
remoteuser = myuser
remotepass = mypassword
ssl = yes
maxconnections = 1
realdelete = no
folderfilter = lambda foldername: re.search("^Lists\.", foldername)
```

Now, simply running "offlineimap" should sync your mailing lists into
`~/Library/Caches/OfflineImap`. (You'll need to do this regularly,
e.g. before and after reading your lists. Julien Danjou recently wrote
[a nice elisp wrapper for offlineimap](http://julien.danjou.info/offlineimap-el.html).)

All that remains is to tell Gnus how to access your local mail cache.

In .gnus:

```scheme
(setq imap-shell-program "dovecot -c ~/.dovecotrc --exec-mail imap")
(setq gnus-select-method '(nnimap "Mail"
                                  (nnimap-stream shell)))
```

Now you can start Gnus with `M-x gnus`, and then press `^` to enter
the server buffer. Drill down into the "nnimap+Mail" server and use
`u` to subscribe to each of the mailing lists. They should then appear
in Gnus' main `*Group*` buffer.

That's enough to get started reading mail more efficiently, and as
with all things Emacs, there's great potential for customising Gnus to
suit your own preferences.

Further reading

- [GNUS and Gmail setup for dummies - covers configuring Gnus to send mail over SMTP](http://bc.tech.coop/blog/070813.html)
- [Sacha Chua's guide to Gnus + Offlineimap + Gmail - the source for much of this article](http://sachachua.com/blog/2008/05/geek-how-to-use-offlineimap-and-the-dovecot-mail-server-to-read-your-gmail-in-emacs-efficiently/)
- [Gnus homepage](http://www.gnus.org/)
