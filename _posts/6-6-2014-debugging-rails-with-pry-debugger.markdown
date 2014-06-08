---
layout: post
author: Jack Kinsella
title: Debugging Rails with Pry Debugger
---

Part 4 in the series [A Comprehensive Guide To Debugging Rails](/2014/06/06/a-comprehensive-guide-to-debugging-rails.html)

## Rails Debugging with Pry ##

*If you don't yet know what a debugging session is, think of it as opening the Rails console at a chosen point in the execution path.*

I assume below that you have installed the [Pry-debugger](https://github.com/nixme/pry-debugger) and the [pry-stack_explorer](https://github.com/pry/pry-stack_explorer) gems.

At any point in your source code (including within the downloaded code of the gems included into your Gemfile and conveniently opened in the text editor with bundle open gem_name) you can insert the line binding.pry. Whenever the Ruby interpreter executes that line, it stops what it's doing and opens a Pry REPL session at that point.  Had you been interacting with the website via the browser you'll need to switch programs to the terminal console tab in which your Rails server was running for you to see the Pry session.

For the sake of clarity in explaining what is to follow I include a code-snippet here.

    def place_everyone_on_sale
      Seller.all.each do |seller|
        place_on_sale(seller)
      end
    end

    def place_on_sale(seller)
      binding.pry          # Execution will stop here.
      new_products = generate_products(seller)
      new_product.advertise
      new_products
    end

    def generate_products(seller)
       seller.documents.each do |document|
         document.place_online if document.releasable
       end
    end

Within your Pry console you have all the features mentioned already to inspect state or introspect your program with the likes of ls product. Debugging adds stack navigation across stack frames. Lets lie a little and define a stack frame as a "REPL console opened up at any of the possible points along the stack trace Why might we want to **navigate** stack frames? To further pinpoint our error by looking for more specific causes. We do this sometimes by looking for the moment when a certain variable changes value (e.g. a cookie gets set). Other times we navigate to observe the flow of execution, comparing what we expect with what we see. For example you might notice that the wrong branch of an if-else construct was executed.

Having executed `place_everything_on_sale` in the code snippet above, you'll find yourself launched into a Pry session within the `place_on_sale` method and presented with a question of what you'd like to do next.

* The **step command** continues execution by moving you *into* the method on the next line, changing your stack frame to be inside that method. Phrased another way it goes deeper. Following our code example, running `step` will bring you within the `generate_products` method, at which point you'll be asked what you'd like to do next.

* You've "stepped" into the `generate_products` method with `step` above, but now youve decided that you want to skip to the end of the `generated_products` method without the debugger asking for your choice of navigation command after every line. Type `finish` to execute until the current stack frame has run every line, closed and return a value, thereby surfacing by one level, that is moving back into the stack frame from which you had previously stepped out of. Following the example, that brings you back into the `place_on_sale` method to the point after the interpreter has evaluated `generated_products`.

* The **next command** runs the current line and moves to the next line or method in the *current context*, i.e. progressing without changing stack frame. Phrased another way, continue one line down the current method without going deeper. Looking at the code example, (and pretending that we'd just restarted our program , run `place_everything_on_sale`, and freshly opened up a Pry session), typing `next` will completely execute the generate\_products without dropping you into its internals then it will assign the return value to the new_products variable. Nexts are bigger that steps, or in Rails terms, a next has_many steps. All the code within the generate\_products method (which would otherwise be many steps), has been concluded with a single use of the `next` command. Your next navigation decision will be whether to step, next at `new_product.advertise`.

* Abandon the Pry session and continue the program execution as normal with **the `continue` command**. If the interpreter encounters another binding.pry statement, (which will happen when you call the `place_everyone_on_sale` method above), it will execute the place_on_sale method once for every seller, therefore opening a Pry session on every iteration. This can be incredibly annoying, since your program will stop and you'll have to navigate the debugger every single time, so you'll probably want to type `exit-program` to cancel the effect of any following binding.pry statements, without, so to speak exiting your Rails program.

* **View the source code of the method you are currently within:**  `whereami` Great for confirming that you are in the right class or for seeing where you have ended up after travelling through a few frames in your debugging session.

* **Print and navigate call stack** When an exception is raised in Ruby it prints a stack trace of all the methods called prior to that exception. Sometimes you want to view the stack trace thus far despite there being no exception raised. Thanks to one particular pry extension installed by adding the `pry-stack_explorer`  gem, you can do this with `show-stack -v`. This command outputs the stack trace, indicating the current frame with an arrow. You can navigate to another frame with up or "up {n}", e.g. up 3 to go upwards three frames, that is move your REPL to the context of the method that called the method (and so on...) that eventually called the method in which you are currently placed. Type `show-stack` to see where you have moved to in the stack, and down to move frames in the opposite direction.

* **Exit context with a value:** Sometimes you want to manipulate program flow by returning a certain value from a Pry session. For a strained example, imagine you had a line of code that read `first_name = binding.pry`. The first_name variable is assigned the output from the Pry session, and you can set this value to jack with `exit "jack"`.

Sometimes you want to specify exactly when the binding.pry will crack open a pry-session. I do this with Ruby code conditionals:


     binding.pry if session[:added_to_cart] == true
     binding.pry if @first_name == "Jack"
     binding.pry if iteration > 4

