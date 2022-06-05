---
layout: post
title: "Rails/jQuery magic: marking external links with a CSS class"
date: 2008-04-06
comments: true
categories: [css, javascript, jquery, Rails]
---

Want to mark external links on your website with a little icon or a
different colour?  Well, you'll want to give all those `a` tags a
CSS class, and style them up accordingly.  In this article I present
an easy way to do this without directly altering all the links in your
application, exactly as I implemented it on this
[popular celebrity charity news site](https://www.looktothestars.org/).

<!-- more -->

### jQuery, and its use in Rails apps

While us denizens of the Rails world have been using the Prototype
javascript library for years, great alternative libraries have become
popular. Among them, [jQuery](https://jquery.com/) is the reigning king.
jQuery is particularly good at selecting multiple parts of an HTML
document and manipulating them en-masse, but Rails needs Prototype, both
libraries weight in at over 120kb in total, and the two don't live
happily together anyway.

Thanks to Aaron Eisenberger's nifty
[jRails plugin](https://ennerchi.com/projects/jrails), though, we can
evict Prototype from our Rails applications and use the shiny new
jQuery toys instead.

### Finding external links using jQuery

Let's define an external link as an `a` with an href attribute
pointing to an 'http' URL that doesn't start with the current site's
full base URL. Playing in [Firebug](https://www.getfirebug.com/)'s
console, we can try to find these elements using jQuery. First, the http
links:

```javascript
>>> $('a[href]').filter("[href^=http]").size()
111
```

Now, skip the links to the current site, which I'm running at "https://localhost:3000":

```javascript
>>> $('a[href]').filter("[href^=http]").not("[href^=https://localhost:3000]").size()
9
```

I (personally) don't want to do anything to links containing images, and
I can skip those as follows:

```javascript
>>> $('a[href]').filter("[href^=http]").not("[href^=https://localhost:3000]").not(":has('img')").size()
2
```

Excellent! And it's possible to specify all of that in one jQuery
selector, which looks like this:

```javascript
>>> $('a[href^=http]:not("[href^=https://localhost:3000]"):not(":has(\'img\')")').size()
2
```

So we can wrap this up in a function as follows:

```javascript
function externalLinks() {
  return $('a[href^=http]:not("[href^=' + document.domain + ']"):not(":has(\'img\')")');
}
```

### Marking those external links

Now we've easily found the elements we want to modify, here's where
jQuery will put another smile on our face:

```javascript
externalLinks().addClass("external");
```

To make this happen automatically from, say, a Rails app, we can put the
"externalLinks" function in our application.js, and put the following in
our master layout template:

### A sprinkling of CSS

Let's add a little "exit" icon after the text of each link:

```css
a.external {
  background:transparent url(../images/external-link.png) no-repeat scroll right center;
  padding-right:17px;
}
```

#### More

-   [See the technique in action](https://www.looktothestars.org/)
-   [Subscribe to read more articles like this](/rss.xml)
-   [jQuery homepage](https://jquery.com/)
-   [jRails plugin](https://ennerchi.com/projects/jrails)

