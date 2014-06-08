---
layout: post
author: Jack Kinsella
title: A Comprehensive Guide To Debugging Rails
subtitle: Feedback systems for finding errors in your web application
---

The most important tool a musician owns is not their instrument; it's their mirror. Observable physical issues precede degradations in sound, and the saxophonist practicing "blind" may never notice that a misplacement of their thumb over a key caused the grating tone that has tormented them-and their neighbours-for months.

Code problem identification, which is the essence of debugging, benefits similarly from the use of observation, but its mirrors, peering instead into a software process, take the form of logs, debuggers, alerts, OS-level tools, and the instrumentation you design and insert into your codebase.

For three months I've jotted down every mirror I glance at in tending to [Oxbridge Notes](http://www.oxbridgenotes.com) as part of my efforts to create documentation that will enable another programmer to take my place. This article therefore focuses on the mirrors available to a programmer like me, a web developer working with legacy code in Ruby on Rails, Javascript, Git, OS X, and Heroku. The specifics differ to the extent that your stack deviates from mine, but any web developer should find some measure of value in these techniques.

- [ Ruby / Rails Built-in Tools](http://localhost:4000/2014/06/06/debugging-rails-with-built-in-tools.html)
- [ Pry Console ](http://localhost:4000/2014/06/06/debugginging-rails-with-pry-console.html)
- [ Pry Debugger ](http://localhost:4000/2014/06/06/debugging-rails-with-pry-debugger.html)
- [ Operating System Level Mirrors ](http://localhost:4000/2014/06/06/debugging-rails-with-operating-system-tools.html)
- [ Git Source Control Mirrors ](http://localhost:4000/2014/06/06/debugging-rails-with-git.html)
- [ Online and Third Party Mirrors ](http://localhost:4000/2014/06/06/debugging-rails-with-online-or-third-party-tools.html)
- [ Logs, aka Historic Mirrors ](http://localhost:4000/2014/06/06/debugging-rails-with-logs.html)
- [ Memcached Mirrors ](http://localhost:4000/2014/06/06/debugging-rails-with-memcached.html)
- [ Custom Instrumentation](http://localhost:4000/2014/06/06/debugging-rails-with-custom-instrumentation.html)
- [ Chrome DevTools Mirrors ](http://localhost:4000/2014/06/06/debugging-rails-with-chrome-devtools.html)

I'd like to credit Ed Tee at [GigSounder](http://gigsounder.com) and
[Richard Conway](http://richardconroy.blogspot.com) for help with
proof-reading and feedback, and to thank [Hacker Retreat
Berlin](http://hackerretreat.com/) for providing me with brilliant
programming mentors and teachers.
