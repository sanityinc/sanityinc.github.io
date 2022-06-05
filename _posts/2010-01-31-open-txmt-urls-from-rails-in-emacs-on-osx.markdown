---
layout: post
title: "Open \"txmt:\" URLs from Rails backtraces using Emacs on OS X"
date: 2010-01-31
comments: true
categories: [Emacs, Mac, OSX, Rails, Textmate, Ruby]
---

When Rails prints a backtrace in HTML, it's helpfully rendered as a
"txmt:" link so that users can click open the corresponding location
in TextMate on OS X. If you're an Emacs user, here's how to make those
URLs open in Emacs instead.

<!-- more -->

First, get a copy of Daisuke Murase's
[emacs-handler](https://github.com/typester/emacs-handler) project
using git or by downloading a tarball.

Then apply the following patch:

``` diff
diff --git a/Info.plist b/Info.plist
index 1880412..deb1fa4 100644
--- a/Info.plist
+++ b/Info.plist
@@ -8,6 +8,7 @@
                        <key>CFBundleURLSchemes</key>
                        <array>
                                <string>emacs</string>
+                               <string>txmt</string>
                        </array>
                        <key>CFBundleURLName</key>
                        <string>org.unknownplace.emacshandler</string>
```

Alternatively, you can just check out
[my clone of emacs-handler](https://github.com/purcell/emacs-handler),
which has the above patch built-in.

Finally, open the project in Xcode, and build it. Fire up the
resulting `EmacsHandler.app`, and edit the app's preferences to point to
your Emacs.

That should be all you need to do -- just keep `EmacsHandler.app` around
somewhere on your Mac.
