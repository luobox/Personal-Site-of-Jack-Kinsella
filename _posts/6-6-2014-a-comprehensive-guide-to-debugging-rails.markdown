---
layout: post
author: Jack Kinsella
title: A Comprehensive Guide To Debugging Rails
subtitle: Feedback systems for finding errors in your web application
---

The most important tool a musician owns is not their instrument; it's their mirror. Observable physical issues precede degradations in sound, and the saxophonist practicing "blind" may never notice that a misplacement of their thumb over a key caused the grating tone that has tormented them-and their neighbours–for months.

Code problem identification, which is the essence of debugging, benefits similarly from the use of observation, but its mirrors, peering instead into a software process, take the form of logs, debuggers, alerts, OS-level tools, and the instrumentation you design and insert into your codebase.

For three months I've jotted down every mirror I glance at in tending to my law notes selling software as part of my efforts to create documentation that will enable another programmer to take my place. This article therefore focuses on the mirrors available to a programmer like me, a web developer working with legacy code in Ruby on Rails, Javascript, Git, OS X, and Heroku. The specifics differ to the extent that your stack deviates from mine, but any web developer should find some measure of value in these techniques.


* Ruby / Rails Built-in Mirrors
* Pry Console
* Rails Debugging with Pry
* Operating System Level Mirrors
* Git Source Control Mirrors
* Online and Third Party Mirrors
* Logs, aka Historic Mirrors
* Memcached Mirrors
* Our Custom Mirrors
* Chrome DevTools Mirrors
