# Streamlined Yard Work #

In my [recent article](/2010/08/12/about-this-website/) describing the system that powers this website, I discussed some "yard work". I use this term to refer to tasks that I accomplish using Ruby's [Rake](http://rake.rubyforge.org/). Since I published that article, I've made several improvements to the Rakefile that powers most of my website's common operations. As such, I figured that I'd post a more in-depth description of the lovely scripting solution that I've come up with.  

To begin, I wanted to make the output from the Rake tasks more stylish and readable. I took inspiration from [Homebrew](http://mxcl.github.com/homebrew/), and wrote this function:

<script src="https://gist.github.com/1257914.js?file=printHeader.rb"></script>

This depends on the excellent `term-ansicolor` gem, and produces command-line output that looks something like this: ![Compiling website...](/images/posts/2010-08-22-streamlined-yard-work/sampleHeader.png). It distinguishes itself from the other command line output, so that you're instantly drawn to the more important text (the headers). Of course, this would mean nothing if I didn't use it.  

The default rake task is set to `develop`. This is the task I run whenever I'd like to work on the site locally, preview an article as I write it, or test any new features without deploying them to the server. Here, take a look:

<script src="https://gist.github.com/1257914.js?file=rakeTasks.rb"></script>

Don't worry:  I can hear you yelling and screaming. You thought this was going to be simple. Ha! The develop task basically re-implements a lot of the things that the `jekyll` command line utility usually does. I did that so that I could control the output and the order in which code was executed. First off, the `develop` task runs the `build` task. The build task simply creates a generic Jekyll site object and processes it, forcing it to use the `_config.yml` that resides in my site's directory. The `site` object is kept around so that I can re-use it each time a file gets changed.  

The `develop` task then starts up a directory watcher, which monitors the source directory for any changes. Whenever a file is changed, the site is re-processed so that the files in the `_site` directory are always current. Currently, it processes the entire site again whenever a file is changed, which I'm sure is extraordinarily inefficient. If you have any idea how to make Jekyll only re-process the changed files, I'd love to know.  

After the site is built and the watcher is running smoothly, a web server is started. I'm using the `WEBrick` web server (comes with Ruby), mostly because of how easy it is to configure. I considered using [Thin](http://code.macournoyer.com/thin/), but it requires I use an adapter like Rack, which seemed unnecessary when I was simply serving static files. I have the server configured to only log errors to the console, which is important:  it keeps my command line clean, unless there is an actual issue. This is easy to modify if you want to actually see your access log, but I don't. The server spins up, the website opens in the default browser, and yet another header is printed.  

See? That wasn't so complicated after all!  

The `deploy` has actually stayed pretty much the same (with the exception of headers) since the first post about it, so I won't go into it here. If you're interested in using this Rakefile in your own project, feel free to [check it out on GitHub](http://github.com/CarterA/cartera.me/blob/master/Rakefile.rb).