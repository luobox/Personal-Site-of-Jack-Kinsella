---
layout: post
author: Jack Kinsella
title: Debugging Rails with Online or Third Party Tools
---

Part 7 in the series [A Comprehensive Guide To Debugging Rails](/2014/06/06/a-comprehensive-guide-to-debugging-rails.html)

## Online and Third Party Mirrors ##

* **Google Webmaster Tools:** Google Webmaster Tools helps you evaluate your websites health in Google search engine results by providing reports about how many URLs were indexed by Google, what search engine queries your website ranks for, and how many URLs were contained in your sitemap. Webmaster tools also lists web-crawler errors, thereby indicating pages that 404 or have incorrect permissions. Webmaster Tools helps you avoid issues catastrophic to your SEO operation, therefore you don't want to miss a single issue they raise. Keep in the loop by configuring their alerts setting to email you "All issues".

* **Google Search Results** We all Google our bugs and errors, but how does one increase the number of relevant results? Start by stripping platform specific information from your search string. For example take an error raising stack trace that contains the following:
```
/Users/jkinsella/.rvm/gems/ruby-1.9.3-p392/gems/activesupport-4.1.1/lib/active_support/dependencies.rb:247:in `require'
```

If you Google that full string you will get no results that help explain your exception Google will search Stack Overflow, mailing list archives and other websites for an error containing the user string "jkinsella", the ruby version "ruby-1-9-3.p392" and active support version "4.2.1"an exceedingly unlikely combination. A better Google query would be "active_support dependencies.rb:247:in `require'", since that will return results for backtraces by people with any username, any Ruby version, and (nearly) any version of ActiveSupport, a much broader search that's more likely to deliver results.

* **Email delivery reports:** Sometimes your Rails application sends off emails in production, yet, without raising any exception, your email silently fails to reach the intended recipient. You might only become aware of this weeks later when you notice low customer activation rates. Whenever you suspect email delivery issues, log in to our email delivery provider Sendgrid through the Heroku dashboard and check the  "Email Reports" tab for bounces (especially soft bounces), blocks, and spam reports. Better again, enable all of Sendgrid's delivery report alerts so as to stay automatically informed.

* **New Relic:** Information about Ruby exceptions raised, application uptime, and application speed, whether that be the speed of web-requests, database calls,, external web service calls (e.g. to API providers like Amazon s3 or Searchify), or browser rendering times. New Relic rocks for debugging performance issues. It differs dramatically in production and development mode so it's best to think of them as separate tools: the production tool focused on post-facto reporting and the development tool on in-depth debugging. Typically you might use New Relic production (accessed via the Heroku dashboard) to identify problem *areas*, then having picked a problem to debug, you'd load up the development tool to debug *a known problem*. The reason for this division is motivated by the realisation that you can, at great cost in time/money, optimise the performance of almost any component within a piece of software, but only a select few of these changes will make any noticeable difference to the user experience. To use the development New Relic tool, load up the application locally using our special development "caching_on" environment (Why not the normal development environment? Because development usually reloads Ruby classes on every request, making it unrealistically slow and skewing New Relic results. Read more about [configuring environments here](http://guides.rubyonrails.org/configuring.html).) Visit /newrelic, perform a slow action in another tab and refresh. By default New Relic displays a breakdown of the SQL statements and the Ruby methods that generated these statements. If you'd like in depth information about how long each Ruby method took to run, then you need to click "Start Profiling" within "/newrelic", and run the slow command again.
