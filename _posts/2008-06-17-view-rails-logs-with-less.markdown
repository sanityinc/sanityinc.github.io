---
layout: post
title: "Rails tip: easily browse and search logs in colour with \"less\""
date: 2008-06-17
comments: true
categories: [Rails, Ruby, Unix]
---

'less' is a great tool for browsing Rails log files, though you might
not guess it if you try to view your "development.log" with it.

<!-- more -->

### Take the colour back

Rails writes xterm control characters into log files to colour
them. Usually 'less' escapes those characters, leading to an ugly
display -- run `less -R` to stop this escaping, allowing you to browse
log files in glorious technicolour. (Set your $LESS environment
variable to "-R" to make this the default.)

### Follow the end of the log file

`Shift-g` will take you to the bottom of the log files (Use `ctrl-c` if
less then pauses while calculating line numbers in a very large file).

`Shift-F` makes less work like `tail -f` -- it watches the end of the
file for new data.

### Search for phrases or pesky backtraces

Use `/` to search forwards, and `?` to search backwards.

To find the last Ruby stack trace in a log file, open the logfile in
less, `Shift-g` to the end of the file, then search backwards using
"?`" (backtick) -- usually backticks are only found in Ruby
stacktraces, at least if you're not using mysql.
