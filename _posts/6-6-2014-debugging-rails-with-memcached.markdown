---
layout: post
author: Jack Kinsella
title: Debugging Rails with Memcached
---

Part 9 in the series [A Comprehensive Guide To Debugging Rails](/2014/06/06/a-comprehensive-guide-to-debugging-rails.html)

## Memcached Mirrors ##

* **Memcached general stats:** In production you can use the Heroku dashboard to access detailed stats about Memcached usage. You'll know you're doing it right if you have a high **hit rate**, a low **eviction rate**, and a healthy excess of memory used compared to the allocated Memcached size (Once you run out of space Memcached [deletes the oldest cached item](http://stackoverflow.com/questions/11222309/how-data-is-replaced-in-memcache-when-it-is-full-and-memcache-performance), reducing the effectiveness of your caching). Memcached won't alert you whenever your cache is in a poor state, so you'll need to log in and check regularly. Indeed I found my cache in a rotten form when I was researching this article. You can also view global Memcached stats with the Rails console using `Rails.cache.stats`. Read this for a [legend for reading memcached stats output](http://www.pal-blog.de/entwicklung/perl/memcached-statistics-stats-command.html), and then understand some confusing nuances with [this Stack Overflow discussion](http://stackoverflow.com/questions/6868256/memcached-eviction-prior-to-key-expiry/10456364#10456364).

* **Memcached Cache contents:** In your codebase or in the console, set the value for a cache key with `Rails.cache.write(key) { code_that_returns_value }` or `Rails.cache.fetch(key) {code_that_returns_value }`. Read the value associated with a particular key using  Rails.cache.read(key). For cached content set at a controller level, for example set with with `caches_action`, the cache key isn't easy to guess from what you read within the code. Figure out the key by *temporarily* setting the log level on production to debug with `heroku config:add LOG_LEVEL="debug"` then searching for entries starting with "Cache" that get triggered following a request to the particular page you are debugging. One example of such an entry is "Cache read: views/www.oxbridgenotes.co.uk/?cache_tag=1398678715/1379180679/407/6804/1398699264&format=html.html". To inspect the contents of this cached entry within the console you'll want to type Rails.cache.read("views/www.oxbridgenotes.co.uk/?cache_tag=1398678715/1379180679/407/6804/1398699264&format=html.html"). I warned you that you'd be unlikely to guess the key.
