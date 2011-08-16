--- 
title: Better Singletons in Objective-C
layout: post
syntax-highlighting: yes
---

Singletons are special classes which have only one valid instance in an entire application or context. They are similar to global variables in that anything that tries to access them will always find itself sending messages to the same actual object as anything else. Singletons are very common in apps that utilize Objective-C. Apple's often-used singletons include `NSFileManager` and `NSUserDefaults`.  

How to implement a singleton object in Objective-C yourself in the most correct way possible is a matter of quite a bit of contention, though it has recently settled down around one particular pattern:  the use of the `dispatch_once` function to prevent an object from ever being initialized twice. However, there are a few nuances in how these new-age singletons should be implemented, and that's why I've chosen to outline what, in my view, is the "correct" way to implement your own singleton.  

Without further ado, here is my basic implementation of a basic Objective-C singleton:

{% highlight objc %}
@implementation Singleton

+ (Singleton *)sharedInstance {
	static Singleton *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [[self alloc] init];
    });
	return globalInstance;
}

@end
{% endhighlight %}

What you may immediately notice if you have ever seen older singleton implementations is that there is only one method here. Many singleton implementations override every possible memory management method (including `retain`, `release`, and even more obscure methods such as `allocWithZone:`) to return the same single instance of the class. This is a Bad Thing™ for a few reasons. First, it's largely unnecessary. Unless you are writing a framework that will be used by millions of apps, the only person who is going to be using your class is, well, you. Coding defensively is all well and good, but you can definitely go overboard, and overriding all of the memory management methods is decidedly beyond the point of necessity. Second, overriding those important methods of NSObject can lead to undefined behavior, and is an even bigger problem when using the newly-announced [Automatic Reference Counting](http://clang.llvm.org/docs/AutomaticReferenceCounting.html) system.  

This new pattern also has a fairly large benefit, which is that while the default behavior of the class is to only create a single instance of itself, it is still entirely possible for the class's client to create separate instances of the class if the need arises. This is how many of Apple's singleton classes work, a good example of which is `NSUserDefaults`. Most of the time your app is using `NSUserDefaults`, it is completely acceptable to simply use its shared instance, accessed via `[NSUserDefaults sharedUserDefaults]`. However, some complex behaviors in your application may require customizing the domain of the entire user defaults object. If that situation arises, `NSUserDefaults` has you covered with its other methods which initialize instances which are entirely separate from the singleton.