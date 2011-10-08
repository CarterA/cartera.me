# About This Website #

In December of 2008, the first iteration of this website went online for the world to see. Available at the slightly-cheesy domain name "lifeofcarter.com" (courtesy of my friend [Wil Nichols](http://wilnichols.com/)), it boasted a shiny theme on top of a brand-new installation of WordPress. My first post (still available in the archives of this site) was a short and emotional rant about the current state of my life. Since then I've moved domain names, and the theme of my site has changed many times. The articles that have been written since then range from [geeky](/2009/02/25/safari-4/) and [intelligent](/2009/04/15/understanding-object-oriented-programming-and-the-mvc-system/) to [disturbing](/2009/03/05/transcription/) and [thought-provoking](/2009/01/09/clogged-senses/), and finally to [random](/2009/06/13/seven-ways-to-tell-if-your-band-is-too-old/) and [hilarious](2009/02/20/holidays/).  

A few months ago I made the decision to switch to a different blogging engine for my site. WordPress had served me well, but it simply doesn't suit me well enough. I like lots of control, and I don't need many features. WordPress has too many features that I don't need, and more than that, I don't fully understand how it works. I also came to the realization that using a PHP system for something that gets updated *at most* once a day was a foolish use of server power:  serving static files would be much more efficient. So I set out on a search for the perfect blogging engine.  

## Scouring the Systems ##

The first option that I encountered was [Wheat](http://github.com/creationix/wheat). The reason for not choosing this one was simple: my current shared hosting provider doesn't allow Node.JS, and I wasn't willing to upgrade to a VPS just for a blog. I kept in mind all of the features that Wheat offered, and continued my search.  

The next option I found seemed pretty damn perfect, and was almost my chosen engine. [toto](http://cloudhead.io/toto) gave me several of the features of Wheat that I loved so much:  tight integration with [git](http://git-scm.org/), an emphasis on static files, and support for my favorite markup language, [Markdown](http://daringfireball.net/projects/markdown/). I imported all of my posts from WordPress, went through each of them and reformatted them in Markdown, and configured Toto to my liking. Of course, this was all before I realized that my *lovely* shared hosting provider also doesn't *really* support Rack apps. At this point, I had two choices:  I could stick with Toto and find a different host, or I could just keep on lookin'. Needless to say, I didn't switch hosts.  

Enter [Jekyll](http://jekyllrb.com/). Jekyll is everything that I ever wanted in a blogging engine. Really. It isn't perfect, but what's excellent about it is that if there's something wrong, I know exactly how it works and how to fix it. Jekyll is written in Ruby, just like toto, except Jekyll doesn't rely on Rack or Rails. It runs on the your machine only, and is essentially an added "build" step between you and the browser. I coded this entire site in TextMate using standard HTML5 and CSS3, and then at the end I added just a few little variables to the markup. Presto-chango, my site is built and I am at peace with the world.  

You didn't think I would leave it at that though, did you? Of course not! I haven't even *begun* to brag about all the great ways that my site works.  

## Yard Work ##

Before I began this project, I had absolutely no knowledge of the lovely language that is [Ruby](http://www.ruby-lang.org/). Although I am still no professional, I have developed a fairly strong understanding of the language. One of my favorite Ruby tools is [Rake](http://rake.rubyforge.org/) (it's like Make, but written in Ruby...get it?). All of the major stages of work on my website are  automated via Rake:  development, testing, and deployment. I can begin developing by simply running `cd $blog; rake` from Terminal. That will spin up a testing server at <localhost:4000> and will automatically regenerate files whenever I save them. All of this is accomplished with this fragment of my Rakefile:  

<script src="https://gist.github.com/1257930.js?file=compiling.rb"></script>

I used this setup to comfortably code most of my website. There comes a point, of course, where you need to deploy your beautiful website to a public-facing server. For that, I have another task: `rake deploy`  

<script src="https://gist.github.com/1257930.js?file=deploying.rb"></script>

This task is pretty simple:  it wraps a rather complicated `rsync` command into a nice-and-simple Rake task. It connects to my server via SSH using public/private key pairs so that I don't have to enter a password (the Mac OS X keychain remembers the passphrase for my private key). If you have a host that lets you install gems, you can also set it up so that your server is a git remote and builds the jekyll site whenever you push to it. My host doesn't let me do this though, so I wasn't able to use that option.  

The final bit of yard work in my Rakefile is a task which creates a new post:  

<script src="https://gist.github.com/1257930.js?file=newPost.rb"></script>

Though it's a bit more complicated than the last few tasks, it's still fairly straightforward. It starts by prompting for a title and a file name. It uses those to generate the metadata of the file, and then creates the post file based on the current date. Finally, it sends the path to `mate` (which opens the file in TextMate) so that I can start writing the post body.  

If you'd like to see the actual Rakefile, you can checkout the latest copy of it [on GitHub](http://github.com/CarterA/cartera.me/blob/master/Rakefile.rb).  

Update 8/22/10:  I've improved the Rake tasks that I use, and written about them in more depth [here](/2010/08/22/streamlined-yard-work/).

## A Cavalcade of Cascading Styles ##

My website uses [valid HTML5](http://validator.w3.org/check?uri=http%3A%2F%2Fcartera.me%2F), though a vigilant (or neurotic) reader may note that the CSS used is absolutely full of invalid properties. The reason for this is fairly simple:  [the CSS3 validator](http://jigsaw.w3.org/css-validator/) doesn't allow vendor-prefixed CSS attributes (like -webkit-border-radius, or -moz-box-shadow). I get that rule, I really do. Unfortunately, that means that it is impossible to create a website that actually looks good in most browsers and keep your CSS valid at the same time. I decided to go the "works *and* looks good" route, instead of taking the "looks good to the validator but renders poorly and doesn't really work" approach. Here's an example of how I managed to get the inset shadow of the main content area from only CSS:  

<script src="https://gist.github.com/1257930.js?file=boxShadow.css"></script>

Fun, right? It sure isn't pretty, but it gets the job done. Granted, the shadow doesn't appear in IE7 or earlier, but quite frankly, I'm okay with that. Now, what *does* work in IE7 and earlier is my rounded corners:  

<script src="https://gist.github.com/1257930.js?file=borderRadius.css"></script>

The first three lines cover most browsers that visit my site, but the last line is the most impressive. The `behavior` rule is only used by IE, and it links to a local version of [PIE](http://css3pie.com/). PIE is a JS program that uses IE-specific "filters" (a rendering system only ever used by IE) to implement many of the new CSS3 features that are currently unsupported by the Microsoft browser. Let me just say that it is absolutely amazing, though my one request would be support for inset box shadows (currently being tracked in this [issue thread](http://github.com/lojjic/PIE/issues#issue/3) on GitHub).  

## Syntactical and Semantical Perfection ##

It doesn't take much work to get an XHTML page to validate as HTML5. In fact, it takes nothing more than a switched DOCTYPE. But when I set out to remake this site, I wanted more than just validation:  I wanted the site to actually *use* many of the new semantic elements available in the HTML5 spec. Thus, all of the articles are wrapped in `<article>` tags, and all of the different pages are organized using `<section>`'s. The navigation is wrapped in a `<nav>` tag, and the site uses both `<header>` and `<footer>` tags (though the footer is quite empty at the moment...I should fix that.) All of these elements can even be styled just like traditional HTML elements:  but there's a catch. Some older browsers (I'm looking at one in particular here, and it rhymes with blinternet blexplorer) completely screw up when they hit unknown elements. Luckily, all of this is solved by this simple line of code in my `head` tag:
	
<script src="https://gist.github.com/1257930.js?file=simpleLine.html"></script>

Thank goodness for [Paul Irish](http://paulirish.com/) and his [Modernizr](http://www.modernizr.com/) library.  

## Et cetera... ##

I could go on for hours about this website, if only I could come up with more catchy names for sections. This post has barely touched on the great parts of this site, and way more can be found by poking around the [GitHub repository](http://github.com/CarterA/cartera.me). I hope I've inspired you to create some great websites, or at least to admire this one!