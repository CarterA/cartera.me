# Made on a Mac #

I've written a lot in the past about the various systems that have powered this blog. It's gotten to the point now where the most popular topic on this site seems to be the site itself. However, I've made a major change to how it all works, and I think that it is important enough this time to justify yet another meta-post.  

To quickly recap, this site began life as a WordPress blog. A while ago, I followed a trend and migrated from WP to a ["baked"](http://inessential.com/2011/03/16/a_plea_for_baked_weblogs) blog system called [Jekyll](http://jekyllrb.com/). Jekyll was never really perfect, so I was in a continuous fight against it, monkey-patching whatever I could find to get the thing to work the way I wanted. In addition to that, Jekyll is written in Ruby, a language which I have never *really* liked. I know the syntax and I can write basic programs, but its lack of structure gets to me. Because of this, hacking on Jekyll was never really a pleasant experience, as I was always left questioning how something had ever worked in the first place, instead of actually fixing whatever the latest problem was.  

My never-ending quest for perfection in Jekyll led me to string it together with several other Ruby programs, none of which I had any control over. My simple blog system had massive dependencies, and it finally broke when I upgraded to OS X Lion. That was the final straw:  it was time for something better.  

The problem was, there *wasn't* anything better. No static blogging engine was even close to what I wanted:  minimal, fast, and written in a language that I knew and liked. I'm sure that most readers will be able to guess what happened next.  

## If you want something done right&hellip; ##

I sat down and spent the next couple of days writing my own static blogging engine. The result is an extremely fast and very opinionated app that serves me quite well. This site is generated via compiled Objective-C code, running in a native Mac app. The app has a simple UI, and requires absolutely *zero* command-line usage. Say hello to Tribo:  

<div class="center"><img src="/images/posts/2011-10-16-made-on-a-mac/tribo-main.png" alt="The main (and only) window of Tribo.app"></img></div>

The app takes a specially organized directory of files and transforms them into a functional site. The result is completely static and can be served up by whatever HTTP server you'd like. Posts are written in [Markdown](http://daringfireball.net/projects/markdown) and templates are written in HTML with [{{mustaches}}](http://mustache.github.com) The entire system is extremely fast and uses completely native, compiled code. No VMs, no scripting languages, not even any fork()ing. This is one of the reasons that Tribo is so damn fast, but the biggest reason for its speed is that the app uses some amazing third-party libraries to do the most intensive parts of the process.  

## On the shoulders of cheetahs ##

The obvious bottleneck in Tribo is Markdown processing. Although it is a hell of a lot simpler to parse than HTML, Markdown is in no way a trivial language, and writing my own full-fledged parser is really out of my skill set. After trying out and doing basic benchmarks on several native Markdown engines, I settled on [Sundown](https://github.com/tanoku/sundown). Sundown parses all of the Markdown content on GitHub, and if they trust it, then I trust it too. In my limited testing it was significantly faster than the other choices, namely Discount and PEG-Markdown. It also had the friendliest C API of all the libraries, which made parsing the contents of an `NSString` as Markdown trivial:  

<script src="https://gist.github.com/1291718.js?file=On%20the%20shoulders%20of%20cheetahs%201.m"></script>

To process the template files for the site, I used [GRMustache](https://github.com/groue/GRMustache). There wasn't really a lot of competition here considering it is the only Objective-C Mustache engine, but it worked well. If you haven't ever used Mustache templates before, the Post template for this site is a great example (I've omitted the code for the comments section, but it's irrelevant for the example):  

<script src="https://gist.github.com/1291718.js?file=On%20the%20shoulders%20of%20cheetahs%202.m"></script>

## What I meant by "opinionated" ##

Earlier I described Tribo as "very opinionated," and this will become immediately apparent to anyone other than me that tries to use it. The app expects folders to be named very specifically, to contain files that are formatted *perfectly*, and most of all, the app expects to be used by someone that understands it. Realistically, this means that most people won't want to touch the thing. However, my good friend [George](http://georgews.com) is going to be using it for the next revision of his site, and he has really been enjoying developing with Tribo. There are lots of features of the app that I haven't described that make it a pleasure to use (for me, at least) but that doesn't mean that it is everyone's cup of tea. However, if you are an Objective-C developer, consider how nice it would be to know *exactly* how your blogging software works. I can tell you right now: it sure as hell beats Ruby.  

Tribo is open-source and can be found [here](http://github.com/CarterA/Tribo). You can see how files have to be laid out by taking a look at the source code for [this website](https://github.com/CarterA/cartera.me).
