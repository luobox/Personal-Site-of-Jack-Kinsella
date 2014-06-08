---
layout: post
author: Jack Kinsella
title: Debugging Rails With Built-in Tools
---

Part 2 in the series [A Comprehensive Guide To Debugging Rails](/2014/06/06/a-comprehensive-guide-to-debugging-rails.html)

## Ruby / Rails Built-in Mirrors ##

* **Ruby compiler checks:** Run `$ ruby -c myfile.rb` to ask Ruby to check the syntax of your script and find serious errors that would stop your program from even starting. The syntax checker does not actually run your code, so there's no need to worry about the program being syntax checked performing some destructive action that would occur were the code executed normally. Given the size of a Rails project, it would be a pain in the ass to run this command after every file change. Luckily for us, editor plugins such as Syntactic automatically run the syntax check on saving a file, displaying any resulting errors within Vim.

* **Gemfile.lock:** Contains the exact list of gems used within your application and their version numbers. Useful to refer to because your normal `Gemfile` only displays a fraction of the gems within your application: a single gem within your Gemfile may require 10 others as dependencies, and these extra gems pulled in will only be listed within your `Gemfile.lock`. That's not the only reason you should refer to the `Gemfile.lock` page. Often, and for good reasons, we do not fully specify our gem's version number in the `Gemfile`. For example you might see optimistic versioning such as '>1.0.1' or '~>1.1', which could result in a wide variety of exact versions in use. When troubleshooting, figure out the exact version by referring to the Gemfile.lock.

* **Middleware lister:** Rack middleware is a filter that can be used to intercept a web request and alter the response. Some Rails or Rack related gems insert middleware at various stages in the request, and when debugging you sometimes need to be aware of what middleware has been added and in what order. Run `$ rake middleware` to list the middleware in use. This command can also be useful to ensure that custom middleware you added was picked up by the Rails application and placed in the right place within the middleware chain.

* **View application routes:** List all the URLs your Rails application responds to, the associated URL helpers available within your controllers and views, the parameters each URL expects, and the controller action that route maps to. With pre-Rails 4 you'll need the **sextant** gem installed to view at [http://localhost:3000/rails/routes](http://localhost:3000/rails/routes), with Rails 4 the same output is viewable at [http://localhost:3000/rails/info/routes](http://localhost:3000/rails/info/routes). In all versions you can also list the routes after a brutally long load time with the command line $ rails routes.

* **SQL database access:** Useful to run SQL commands manually when debugging, exploring, or dealing with data integrity issues not easily repaired at the Rails levels (such as primary key problems). Access in production with `$ heroku run dbconsole` and in development with `$ rails dbconsole`.

* **List available rake tasks:** Rake provides command line interfaces to maintenance tasks in your Rails app, many but not all of which are related to modifying the database structure. `$ rake -T` lists all these Rake tasks and prints not just those built into Rails, but also those packaged into your included gems or added by us through custom code within with our projects `Rakefile`.

* **better_errors / frames:** OK this one isn't built into Railsyou need to add two gems to your Gemfile: "better\_errors" and "binding\_of\_caller". Once installed these gems operate in the development environment such that any unrescued exception raised when using the web application from the browser will show the "better\_errors" debugging error page instead of the less informative standard Rails error page. The key helpful features with "better\_errors" are a) the possibility to inspect local and instance variables; b) the possibility to do code experiments in the REPL provided; and c) the possibility to navigate to any previous frames in the stackframe (see the section on debugging for further explanation of frames). Failing ajax request will not usually show the "better\_errors" page, since typically no new webpage was requested. To see the "better\_errors"" console following a failed AJAX request, visit the URL /\_\_`better_errors`.
