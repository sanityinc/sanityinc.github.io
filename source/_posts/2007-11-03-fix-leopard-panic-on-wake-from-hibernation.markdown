---
layout: post
title: "How to fix hibernation panics on Leopard after a memory upgrade"
date: 2007-11-03
comments: true
categories: [Mac, OSX]
---

One of my Macs running OS X Leopard was panicking after I upgraded its
memory; while waking from hibernate, I'd get the grey curtain of death
and the multilingual "reboot this computer" message panel.  If it
happens to you too, you'll be glad to know there's a solution.

<!-- more -->

### Background

When a portable mac goes to sleep, a feature called SafeSleep causes
the computer's active memory to be written to a sleep image file (at
`/var/vm/sleepimage`) before the machine's power light starts pulsing.
The battery keeps the active memory intact while the mac is asleep.
If the battery is removed, the computer is considered to be in
hibernation; when the power is later restored, the operating system's
in-memory state will be restored from the sleep image file.

If the machine's memory gets upgraded, the sleep image file will be
automatically regenerated to match the size of the new physical
memory.  In my case, this regeneration seemed to stop my machine from
waking up properly from hibernation.

### Solution

A little Googling led me to
[this page](http://matt.ucc.asn.au/apple/machibernate.html), which
mentions that there are distinct "encrypted" and "unencrypted"
hibernate modes, that the default mode is "encrypted", and that
problems can occur when secure virtual memory is hibernated into a
sleep image for encrypted hibernate mode.

I had noticed after my Leopard upgrade that in the Security
preferences pane, the "secure virtual memory" option was enabled; I
don't know what its setting was prior to the upgrade, but following
the advice in the above page I executed the following command in a
terminal to set the system's hibernate mode to 7:

```bash
sudo pmset -a hibernatemode 7
```

After this, my Mac will happily wake from sleep.

An alternate solution might have been to disable secure virtual
memory.  If I do so in future, I expect that I would need to set the
hibernate mode to its default value of 3 instead.

### Other hibernation mode tricks

Setting the hibernate mode to 0 will disable hibernation, which will
make your portable Mac skip the creation of sleep image files and so
fall asleep faster, at the expense of being able to recover your
desktop state and open documents if you remove the battery or allow it
to run completely flat while asleep.

Desktop Macs, such as Mac Minis, use a hibernation mode of 0 by
default.  I hear you can also set their hibernation mode to 3 or 7 to
make them create sleep images, and then simply power them off when you
go on vacation, after putting them to sleep, of course.
