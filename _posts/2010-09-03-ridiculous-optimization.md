--- 
layout: post
title: Ridiculous Optimization
syntax-highlighting: yes
---

The latest project I've been working on with regards to this website is optimizing its load time. At first it was simple, obvious things: enable GZip compression on the server, minify CSS and JS, you know:  standard optimization. After that was done, the index page of my site weighed in at about **21.7kb**. Quite lightweight, but that wasn't good enough. So I started on the next step:  ridiculous optimization.  

The first bit of ridiculous optimization is extremely heavy caching of all static files. That may not seem ridiculous, but when the files we're talking about are around a kilobyte or less each, it's quite a bit of trouble for such a minute gain. The issue with caching is, of course, that you need to have some way of invalidating the cached copies if you change something, otherwise they'll never get updated on user's machines. The fix I'm using for this problem is query parameters (like "?revision=whatever" on the end of the URL). When the links are generated for my static files, it appends "?revision=" and the most recent commit hash *that affects the file*. That last bit there is important:  it means that even when I change something else on my site and move to a newer commit hash, the files that are still unchanged remain cached. I accomplish this bit of magic with a Jekyll plugin (place in a .rb file in a _plugins directory in your site folder):  

[View VersionControlledFiles.rb on GitHub.](http://github.com/CarterA/cartera.me/blob/master/_plugins/VersionControlledFiles.rb)  

The second bit of optimization to get rid of [Modernizr](http://modernizr.com/). I know what you're thinking:  *but Carter, your site uses HTML5 and you need Modernizr to enable HTML5 for older browsers, right?*. Wrong. I don't deny that it is an excellent and useful library, but what makes it so big is that it doesn't just enable all sorts of features, it also lets you know which ones are supported. It's the second part that takes a ton of code. I am now using a tiny script that I've had saved in my snippets for a long time (I didn't write it, so if you recognize the source, let me know!):  

{% highlight js %}
(function(){if(!/*@cc_on!@*/0)return;var e="abbr,article,aside,audio,bb,canvas,datagrid,datalist,details,dialog,eventsource,figure,footer,header,hgroup,mark,menu,meter,nav,output,progress,section,time,video".split(',');for(var i=0;i< e.length;i++){document.createElement(e[i]);}})();
{% endhighlight %}

This simply adds each of the new HTML5 elements to the DOM so that IE and older versions of Firefox can style those elements correctly. Best part is, *it's tiny*!  

One more thing:  I mentioned early on that I minified CSS. Now, working with minified CSS is a gigantic pain in the ass, so I wrote another Jekyll plugin to do that:  

[View Minifier.rb on GitHub.](http://github.com/CarterA/cartera.me/blob/master/_plugins/Minifier.rb)  

After all of this, my site now weighs in at about **12.2kb**, and around **6kb** once it has everything cached. Happy optimizing!