---
layout: post
title: "So you think you found a bug in a library?"
date: 2009-06-29
comments: true
:categories: [Programming]
---

From time to time I receive bug reports for the libraries I've
written. Some reports describe genuine bugs (and I'll be the first to
admit I'm not perfect), but far too many others demonstrate a missed
step in the submitter's "bug assessment" mental process.

<!-- more -->

Specifically, ten years ago I wrote the unit testing module included
in Python's standard library. The module was a fairly direct copy of
JUnit's proven design at that time, and has since been used as the
basis of (I'm sure) millions of unit tests in projects around the
globe, including Python itself. It's fairly safe to say that the major
bugs have been ironed out by this stage.

But still, from time to time, I receive emails smugly pointing out a
glaring bug in the module, with indignant comments such as "I am
trying to teach more people in my company to use unit testing, but
after the[y] discover bugs like these they come to me discouraged."

Many such bug reports come complete with a short "demonstration" code
snippet that shows a fundamental misunderstanding of how the library
is to be used. I send polite responses, but I'd rather have simply
been asked for a link to a good tutorial instead.

So here's a question I'd like to request that programmers
(whatever his opinion of his own ability) ask themselves before reporting
a bug in a library they are using:

> "Given the number of people using this library, is it at all possible
> that I could be the first person to discover this bug, or is it more
> likely that I've misunderstood how to use the library?"

