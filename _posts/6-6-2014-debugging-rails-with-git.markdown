---
layout: post
author: Jack Kinsella
title: Debugging Rails with Git
---

Part 5 in the series [A Comprehensive Guide To Debugging Rails](/2014/06/06/a-comprehensive-guide-to-debugging-rails.html)
## Git Source Control Mirrors ##

* **Git Search** `$ git log -Gturbolinks --pretty=oneline` returns all git commits which added or removed "turbolinks", be that a method name, code comment, or part of the documentation. Shockingly fast, this is irreplaceable for figuring out which commits caused a particular change.	

* **Git Log** The output to `$ git log` details the changes made to the code as described by the git commit messages you type, starting with the most recent commit message. Perhaps these messages are enough for you to figure out what happened that might have broken your code, or at the very least to understand what your coworkers have changed. The default printout has a low information density, so I prefer to alias `gl` in my ~/.bashrc file with `alias gl="git log --graph --pretty='format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset'"` then call `$ gl`. 

* **Git Diff:** This command is priceless for comparing the present state of a specific file/folder with its state at a particular commit. `$ git diff 9ce85 -- config/routes.rb` compares the state of the config/routes.rb file with its state at the commit 9ce85.

* **Git Blame:** Sometimes you cannot figure out the purpose behind a line of code. Perhaps the code isn't as "self-documenting" as you hoped, or you find the associated comments opaque. You might have another chance to understand its intention through `git blame`. Git blame acts upon a single file, indicating the commit SHA that last changed each line. In this way you can see *who* last changed that line, alongside the commit message they entered in association with the committing of those changes to source control. These commit messages might explain the purpose of the code, for example in mentioning that the commit was intended to squash a particular bug. While git blame is available on the command line, the git blame UI on Github is far more usable ([instructions on usage](https://help.github.com/articles/using-git-blame-to-trace-changes-in-a-file)), so I recommended that instead.

* **Git Bisect:** Sometimes you have absolutely no idea what's causing a bug, but you do know that the bug did not exist in a previous version of your code. By identifying the git commit that created the bug, you'll dramatically narrow down your search for what exactly caused the issue. Git bisect solves this problem by allowing you to mark a commit you know for certain `contains` the bug as "bad", and another you know does *not contain* the bug as "good", and then checking out different versions between the two marked commits for you to test whether the bug is present. Testing may be carried out by you manually (e.g. refreshing the browser page and seeing if the visual boxes are still misaligned) then marking that commit as good or bad and moving on, or testing may be carried out automatically, using a shell script with that employs the standard linux protocol of exiting with the code zero for good and non-zero for bad. [More detailed information about Git bisect is found here](http://git-scm.com/book/en/Git-Basics-Viewing-the-Commit-History).

* **Github issue reports for the gem:** When dealing with problems arising out of gems used (you'll often know this because lines from the gem library will appear in key places in the stack trace produced by an error), it's often fruitful to search within the issues section of the Github project for that particular gem. Perhaps someone has already solved the issue or created a fork without that error, a fact you’d learn by looking at the "Network" tab in Github and hovering over each commit message to check for a reference to that bug.
