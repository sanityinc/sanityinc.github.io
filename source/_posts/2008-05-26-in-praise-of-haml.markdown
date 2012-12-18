---
layout: post
title: "In Praise of Haml"
date: 2008-05-26
categories: [Rails, Ruby]
---

Our big
[celebrity charity news site](http://www.looktothestars.org/) runs
on Rails, and I've just switched all the view code from erb to haml. I
cut the total number of lines of view code from 2370 to 1788, which
makes for a saving of 25%.

<!-- more -->

Note that I didn't add any helper methods in the process, so the
comparison should be quite fair. If I exclude blank lines from the
comparison, the ratio is about the same, and it's quite impressive
given that a few of the views have significant text content inside
them.

It took about half an hour to switch my brain over to thinking in
Haml, and then it was plain sailing. To my eyes, the views are no less
readable now, and are certainly more concise.

Deleting all those `<% end %>` tags was enormously satisfying, and
almost made me miss Python syntax.

Here's an example of a partial from the site before and after its conversion:

```erb
<div class="section">
<% if (with_birthday_today = Celebrity.all_alive_with_birthday_today).any? %>
<h3>Today's birthdays</h3>
<ul>
  <% for celebrity in with_birthday_today %>
<li><%= link_to_item celebrity %> is <%= celebrity.age_in_years_today %> years old</li>
  <% end %>
</ul>
<% elsif (upcoming_birthdays = Celebrity.birthdays_in_next_month(3)).any? %>
<h3>Upcoming birthdays</h3>
<ul>
  <% for celebrity in upcoming_birthdays %>
<li><%= link_to_item celebrity %> on <%= celebrity.birth_date.to_s(:short) %></li>
  <% end %>
</ul>
<% end %>
</div>
```

and in HAML:

```haml
.section
  - if (with_birthday_today = Celebrity.all_alive_with_birthday_today).any?
    %h3 Today's birthdays
    %ul
      - for celebrity in with_birthday_today
        %li== #{link_to_item celebrity} is #{celebrity.age_in_years_today} years old
  - elsif (upcoming_birthdays = Celebrity.birthdays_in_next_month(3)).any?
    %h3 Upcoming birthdays
    %ul
      - for celebrity in upcoming_birthdays
        %li== #{link_to_item celebrity} on #{celebrity.birth_date.to_s(:short)}
```

Haml's just seen its
[2.0 release](http://nex-3.com/posts/76-haml-2-0), it's approximately
as fast as Erb, and the error messages are really pretty good
now. (Occasionally I left a trailing `%>`, or forgot to indent after
an `- if ...`, and these produced slightly obscure error messages.)

The new release has also added handy filters for embedding Javascript,
Erb and the like inside Haml templates. I'm glad I've finally jumped
on the bandwagon.
