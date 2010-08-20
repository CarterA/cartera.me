--- 
layout: post
title: Introducing CZKit
syntax-highlighting: yes
---

Though it has been publicly available for many months now, I'd like to take a moment and formally introduce my personal collection of open-source libraries of Objective-C/C code, CZKit. Although still fairly small, CZKit has an organized and distributed configuration that will let it grow quite nicely in the future. I use the name CZKit as an umbrella term to identify four different libraries of code (though that number is subject to change). The easiest way to describe the whole kit is to go through each component library individually.

## CZCore ##

This is actually the newest of the libraries, despite what the name might indicate. Originally the plan was to have each library completely independent of the other, so that a developer wouldn't have to include a lot of unnecessary code in their application if they didn't want to. This is true to an extent, but I decided that I wanted to have one library where I could put universal code. This library works on Mac OS X and iOS, and currently only contains some debugging functions. Eventually I might add more low-level functionality to it, so expect its list of functions to grow. Located in the scenic `CZDebugger.h`, you'll find the following useful functions:

{% highlight objc %}CZLog(arguments, ...);{% endhighlight %}
It's kind of NSLog. In fact, it's just a `#define`'d alias for NSLog, with a few extra arguments. It logs the function (or method) name that it is called from, and the line number. Simple, yet helpful.  

{% highlight objc %}CZLogMethodName();{% endhighlight %}
This one is a prime example of how verbose and easy to understand my function names are.  

{% highlight objc %}CZAssert(statement);{% endhighlight %}
This type of function is generally pretty common in unit testing libraries, though I find myself using similar systems while debugging as well. If the passed statement is true, nothing happens. If it is false, it logs the failure.

{% highlight objc %}+ (BOOL)debuggerIsAttached;{% endhighlight %}
This is the only actual method in the CZDebugger class file, and it simply tells you whether your program is currently being debugged. It currently doesn't work in iOS, so it's `#ifdef`'d out for now.

## CZCategories ##

The name pretty much speaks for itself here:  CZCategories is a library of categories for many of Apple's classes. To those of you who don't know, Objective-C categories can be used to add methods to existing classes without actually subclassing them. I won't list all of the different methods (most of them are documented inline using Doxygen-style comments), but there is one particular feature that is worthy of note. The general concern with categories is that there is a possibility of conflicting method implementations if two different third-party categories are loaded and they used the same method names. One of the ways that developers have avoided this is to use prefixes, just like with classes. I have done this with my categories. Here's an example of one of the method signatures:  

{% highlight objc %}- (BOOL)cz_containsOnlyStrings;{% endhighlight %}

It gets the job done, but I like my code to be pretty, and that sure isn't. So I added a preprocessor macro, `CZ_NAMESPACE_PARANOIA`. If it is defined (which it is by default), then all category methods will be prefixed with `cz`. If you include the libraries and `#undef` the macro, then you can use the methods without the prefix. It's as simple as that.  

## CZUtilities ##

The definition of this one is pretty vague, really. It basically encompasses all independent classes that are standalone but are not a UI element. It includes `CZAppPrefs` which is an Objective-C interface built on top of the CoreFoundation preferences suite. It allows you to quickly modify the preferences of any application on the system. CZUtilities also contains `CZColors.h`, which isn't an actual class but simple a set of functions and data structures for working with simple color values in either the HSB or RGB system. It has functions for converting between the two color spaces, which I find *extremely* useful, though most people don't need that at all. The last utility file in there (for now) is `CZGraphics.h`, which also isn't an actual class. It currently contains some functions that can be very helpful if you're using CoreGraphics to draw UI elements; they specifically help with the creation of rounded rectangles. In addition to rounded rectangles, there are a couple functions that can convert `CGRect`'s to strings and log them, which can be a pain to do manually.

## CZUI ##

This one doesn't contain much yet, but it has the potential to be very helpful. As you may have guessed, this library contains custom user interface elements. The only two member classes that are complete are `CZIconImageView` and `CZInsetTextField`. The inset text field is the simpler of the two:  it is a simple subclass of `NSTextField` that draws a subtle inset under the text inside the view. It's helpful if you have a UI that includes a bottom bar and you would like to place text on it, as the inset helps make the text really really pop. `CZIconImageView` is quite a bit more complex, but I think it can be very helpful to developers of Mac applications that deal with files.  

The icon image view is a direct subclass of `NSImageView`, and as such, it displays an image inside a customizable container. `CZIconImageView` differs by letting you set the `representedFile` of the view, which will cause it to display the icon of the file. Apart from allowing you to customize the size in pixels of the icon, it also comes with out-of-the-box for drag-and-drop. If editing is enabled in the view, dropping a file on it will set the `representedFile` to a URL pointing to the dropped file. Even if editing is not enabled, the user will be able to drag the icon out of the image view and drop it anywhere, and the file will be sent to the dropped location. I originally developed this class for the now-defunct video converter, [The Magic Thing](http://github.com/CarterA/The-Magic-Thing).  

## Technical Details ##

I've been told that CZKit is an excellent example of a well-organized and well-thought-out project, and I'd like to think that's true. It may seem a bit overwhelming at first (there are a total of 11 different targets), but once you get to know my organizational systems and habits, the project will become fairly understandable.  

The CZKit project is managed by Xcode, and most of my work on it is done through Xcode as well (though I do use TextMate on occasion). The most recent version of the source code can be found [on GitHub](http://github.com/CarterA/CZKit). All of the libraries can be compiled error-free for both Mac OS X and iOS, though when compiling for iOS, CZUI will contain no actual code and CZUtilities has fewer useful classes. I am working to port most of the classes and features from Mac to iOS, though the UI elements will probably never be ported (the UI needs on iOS are completely different).  

If you want to use CZKit in your own project, feel free to do so. It is released under the MIT license, which means you can use it for pretty much anything you'd like (including commercial projects). You absolutely don't have to credit me if you don't want to, though I'd love to hear from you if you need help with using it or just found a creative purpose for some of my code.  

The libraries are designed to be fairly independent, as I said before, so if you only want to use the categories or utilities, that's quite supported. Just remember to link to your desired library in addition to CZCore. The CZKit framework (for Mac only) is set up to include all of the libraries, though it is trivial to remove some unnecessary libraries from Xcode before you build it.  

I am currently not providing binary releases of CZKit or any of its libraries because it hasn't reached a stage where I want to commit to keeping APIs stable. Once it has reached a truly stable point in its development, I will make binaries available of each library in the Downloads section of the GitHub repository.  

If you have any questions about CZKit, feel free to ask in the comments!