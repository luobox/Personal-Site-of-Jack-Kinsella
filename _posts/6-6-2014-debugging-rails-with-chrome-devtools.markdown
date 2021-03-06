---
layout: post
author: Jack Kinsella
title: Debugging Rails With Chrome DevTools
---

Part 11 in the series [A Comprehensive Guide To Debugging Rails](/2014/06/06/a-comprehensive-guide-to-debugging-rails.html)

## Chrome DevTools Mirrors ##

* **Chrome DevTools Elements:** The Elements tab is helpful in debugging HTML and CSS and for receiving rapid feedback about experimental design changes. To activate DevTools Elements right click a HTML element on any webpage and select "inspect element". You'll see a pane that includes the source code of the final HTML page, as output by your Rails application. Useful features here include dragging and dropping elements into different positions within the HTML source code (thereby modifying layout), swapping HTML tags names by double clicking and renaming (e.g. double click a "p" element and type "h1" to transform it), modifying a HTML attribute (e.g. changing "class=big" to the "small" class by clicking "big" and typing), and adding a new HTML attribute by double clicking the element in question and typing out the attribute. In the right hand column of the Element pane you have tools for working with CSS. Begin by selecting a HTML element in the left hand pane (e.g. a div element you'd like to style differently). In the "styles" tab you'll see the CSS selector classes (e.g. div.large_box ) and the CSS styling commands attached to that selector, giving you an oversight of all the CSS selectors that operate upon that particular element, information not easily discerned from reading CSS files (due to the compilation of many CSS files, presence of inline stylesheets and Javascripts that modify the pages style). Next hover over one particular styling command (e.g. font-size) and you'll see a tick box that enables you to turn the style off temporarily (refreshing the page returns the style to normal). Double click the value assigned to that styling command (e.g. the 12px, attached to font-size), and you can modify it, either by typing a new value or using the arrow keys to select another value. Double click on the closing brace "}" of any selector to add a new CSS statement (e.g. font-weight: bold) . As you already know, CSS layouting sucks. Thankfully, clicking on the "computed" tab in DevTools Elements shows a coloured diagram of the selected element, with its pixel size, alongside its padding, border and margins. Finally, click on the "event listeners" tab (which is usually hidden by an expand options arrow) to see a list of the Javascript events (e.g. click, double click) and elements (e.g. p, h1) that have some Javascript functionality attached.

* **Chrome DevTools JS Errors:** Open up any web page then activate the Chrome Javascript Console (Command+Alt+J). Look for automatically detected Javascript errors. Should you have any of these, such as a syntax error caused by using an incorrect character to end a line (e.g. a colon instead of a semicolon), then you'll see a clickable red "x" sign in the top right of the DevTools menu. Clicking will detail the error

* **Chrome DevTools Console:**. Activate with (Command+Alt+J) and you have a REPL console at your disposal for executing Javascript code and running experiments on page. One gotcha: when debugging your Javascript be aware that due to minification and uglification by Rails, you might only be able to see the Javascript code in human-understandable format within development mode.

* **Chrome DevTools Javascript Debugger:** Refer to [Google's excellent documentation on DevTools Debugger](https://developer.chrome.com/devtools/docs/javascript-debugging) for details. Here's the most important parts with regards to debugging Rails:

  * set debugging breakpoints by inserting the keyword "debugger" into your Javascript source code or entering it visually within DevTools (Sources > Select JS File > Click on some line number so that a blue tag appears). The JS debugger functions much like binding.pry above.

  * set Javascript conditions for the breakpoint to trigger (Right click "edit" when hovering over a breakpoint)

  * view the call stack (i.e. backtrace) and list variables in action at that point (Sources > Call Stack)

  * bring up the Javascript console to look around or experiment within the function where the breakpoint was called (keyword ESC)

  * hover over variables within the breakpointed code in the left-hand panel to reveal their currently assigned values

  * set breakpoints on Javascript events, such as whenever you click or keypress (Sources > Event Listener Breakpoints)

  * set breakpoints on XHR (AJAX) requests to a specified URL (example usages: when a download for the file /chapter_1.txt starts; when a form POSTs to one of your Rails routes) (Sources > XHR Breakpoints > +)

  * pretty print, such that minified Javascript that otherwise has its entire contents written onto one massively overloaded line of code, is spread out onto many separate lines, making it easier to read and visually insert debugging breakpoints. (Source Code File > Curly Braces)

  * Jump to a particular function by popping up an autocomplete search containing all the function names(Command + Shift + 0). Much like using Ctags in your text editor.

  * set breakpoints on DOM manipulations of a specific HTML element (e.g. when a paragraph is added/removed from a div; when an elements "hidden" attribute is modified). (Elements Tab > Select Element > "Break On").

* **Chrome DevTools Network tab:** Sometimes you want to inspect what resources (images, documents, APIs, Javascripts, css files) were requested by your application, and whether these successfully downloaded. Chrome DevTool's Network tab provides a listing of each resource requested alongside the HTTP method used and the HTTP status returned (e.g. 200, 404), For greater detail click on one of these resources and you'll be able to view HTTP headers (including caching information, accept headers and host information), or preview the contents of a resource. If you see no resources within the Network tab despite expecting otherwise, then you need refresh the page, this time with the web inspector open before requesting/refreshing the page.
