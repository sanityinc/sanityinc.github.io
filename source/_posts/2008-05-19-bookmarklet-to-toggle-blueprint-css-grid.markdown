---
layout: post
title: "Use a bookmarklet to toggle the Blueprint CSS background grid"
date: 2008-05-19
comments: true
categories: [CSS, Javascript, JQuery]
---

I'm a big fan of
[grid-based layouts](http://del.icio.us/popular/grids), particularly
using CSS frameworks like
[YUI](http://developer.yahoo.com/yui/grids/). For all their apparent
conflict with the ideals of semantic markup, these frameworks save a
ton of time.

My current favourite is
[Blueprint CSS](http://developer.yahoo.com/yui/grids/), which I used
for the recent redesign of our
[celebrity charity news site](http://www.looktothestars.org/), and I
found a neat way to toggle the positioning grid on and off with a
bookmarklet instead of by changing the site's HTML templates.

<!-- more -->

Blueprint conventions have the developer put the page body inside an
element with the class "container"; adding the additional class
"showgrid" to that element shows a background grid, which is handy at
design-time when working on aligning everything nicely to the grid.

Here's the trivial bookmarklet for if you're already using
[jQuery](http://jquery.com/) on your site (and you should be):
[Toggle BP Grid](javascript:void($('.container').toggleClass('showgrid'));).

With the grid off, here's what you might see:

![](/images/blueprint-grid-off.png)

And with a quick click of the bookmarklet, you would see this:

![](/images/blueprint-grid-on.png)

And if you're not using [jQuery](http://jquery.com/), here's the same
bookmarklet with a hook to load jQuery into your page first:
[Toggle BP Grid](javascript:void((function(){var%20s=document.createElement('script');s.setAttribute('src','http://jquery.com/src/jquery-latest.js');document.getElementsByTagName('body')[0].appendChild(s);void(s);$('.container').toggleClass('showgrid');})())).
