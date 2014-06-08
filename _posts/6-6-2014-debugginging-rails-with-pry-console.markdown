---
layout: post
author: Jack Kinsella
title: Debugging Rails with Pry Console
---

Part 2 in the series [A Comprehensive Guide To Debugging Rails](/2014/06/06/a-comprehensive-guide-to-debugging-rails.html)

## Pry Console ##

Step one in programming with Rails: replace the typical Rails console (based on IRB) with the superior console provided by the “pry” gem.

Amongst other things Pry is fantastic for browsing the contents of your codebase. You’re probably thinking you can also browse your available functions and classes through other means such as **ack** and **Ctags**, but both suffer some limitations and therefore offer only an imperfect view of your codebase. **Ack** typically operates at a folder level and therefore you exclude from your search code within your gems. **Ctags**, configured correctly, can easily include the code from your gems, but still shows an incomplete picture owing to its inability to tag functions that were created dynamically by your Ruby code, such as with define_method. Your Pry console, however, offers a more complete reflection and registers all classes and methods already required or dynamically defined.

* The **ls command** is essentially a unified wrapper to a number of Ruby's introspection mechanisms, including (but not limited to) the following: #methods, #instance\_variables, #constants, #local\_variables, #instance\_methods, #class_variables, and all the various permutations thereof. Run in the context of the current object with `ls` alone, or in the context of another Ruby object by providing it as its first argument `ls product`. 

* **Filter results of ls to only see methods containing the string 'map':** `ls -G map` or methods within the module Repo that start with the letter 'b' : `ls -M Repo --grep ^b`

* **cd command**, change "self", i.e. the object within which you sit and observe your application, to another Ruby object. Example: `cd product`, or, since classes are also objects within Ruby, you can also run `cd Spree::Product`. The cd command allows you to move into an object, thereby introspecting local variables easily and calling private methods without the awkwardness of accessing them from outside an object with code such as: `obj.send :method_name` . To leave an object and return back to where you came from type `cd -`.

* List **global variables:** `ls -g`

* List **constants:** `ls -c`

* See all **methods within a namespace whose *names* contains** the word currency: `find-method currency Spree`. This is slower albeit more thorough than typical acking, for the reasons mentioned above.

* **Find all methods whose contents or *comments* contain the word currency:** Similar to the previous point, except with an added flag you can use this function to peer *inside* method definitions: `find-method -c bug Spree`

* **View latest exception:** The latest exception is contained within a special variable `_ex_`. See its backtrace with `wtf`? and the code that raised the exception with `cat --ex`

* **View source code of**
  * **any method in your application or its gems:** `show-source Spree::Product#bought_since`
  * **of a class, separating each monkey patch out:** `show-source -a Spree::Product`. Great for when the source code doesn’t reveal why a class/method is acting the way it is, and you suspect a monkey patch quietly overriding some functionality.
  * **of a Proc/lambda:** `show-source my_proc` Typically in Ruby you cannot inspect the contents of a Proc, so this is damn nifty debugging feature.
