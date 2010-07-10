---
title: Understanding Object-Oriented Programming and the MVC System
layout: post
---



<h3>Introduction</h3>
Before you begin to learn the basic syntax of Cocoa (the API created by Apple for writing desktop Mac applications in Objective-C), you must first gain a firm grasp of the following two concepts:<br />
&nbsp; a. Object Oriented Programming<br />
&nbsp; b. The Model-View-Controller System (MVC)<br />
Object Oriented programming is a way of writing code that allows you to create multiple "objects," which each have properties, and actions that they can perform. The MVC System provides a basic guideline for organizing a project with multiple classes that each perform specialized tasks.<br />
<h3>Object Oriented Programming</h3>
I'm going to go out on a limb here and use a car analogy. Ever model of car has its own blueprint, which the manufacturer uses to build lots of copies of this same type of car. Yet once each car has been created, it is given its own defining features, such as color, drive, and location. The owner can customize their car by doing lots of unique actions to it (painting it a new color, replacing the seats, etc.) But no matter how much the owner customizes their car, it is still based off of the original blueprint that was created by the manufacturer.<br /><br />
Jump time. The blueprints that the manufacturer used to make lots of copies of this same model of car are now called <em>classes</em>. Each car is now an <em>object</em>, and each <em>object</em> is an <em>instance</em> of the <em>class</em>. All of the little defining features of each car, those are <em>variables</em>. And the little actions that the owner takes to customize the car, those are <em>methods</em>.<br /><br />
Take a deep breath, that's a lot to take in in such a short amount of time. Lets go over it again, shall we?<br />
&nbsp; Class:  A blueprint. A definition of how an object can be created.<br />
&nbsp; Object:  An instance of a class. In other words, something built from a certain blueprint.<br />
&nbsp; Instance:  An object that was created using a class as a blueprint. For instance, for the car analogy, a Porsche 911 owned by myself (I wish) would be an <em>instance</em> of the Porsche 911 class.<br />
&nbsp; Variable:  A property of an object. Something that defines it. In the car analogy, the color of the car would be a variable.<br />
&nbsp Method:  An action that something can take that changes a variable of an object. Using the car analogy, this is something that a person can do to change the properties of the car.<br /><br />
So, I know what you're thinking:  <em>How the hell does this relate to Programming?</em> Well, I'll give you a real-world example:<br /><br />
Say I want to have an app that, when it starts up, display a window. <strong>Quick Disclaimer:  This code is BY NO MEANS something that would actually work, so do NOT write to me, telling me that my example doesn't work. This is just to drive my point home.</strong> To do so, I would send a message to the application telling it to display a window. In this case, the application that I'm sending a message to is the <em>object</em>, and the message I'm sending is what we call the <em>method</em>. Remember, a method is an action you can take on an object. Again, this wouldn't actually work, but...<br /><br />
[Application displayWindow];<br /><br />
Make sense? Good. I'll go over more of proper Objective-C syntax in a later tutorial, don't worry.<br /><br />
I dunno about you, but I am totally ready to move on to MVC!<br /><br />
<h3>The Model-View-Controller System</h3><br />
Now you're thinking:  <em>Crap, this sounds complicated...</em>and it is! Nah, not really. You just have to understand what we're going for. The idea of MVC is it is simply a way of organizing the way that the User Interface (UI) interacts with the code, and how the code in turn can change things in the UI and respond to the user. To explain, I'm just going to give you a description of each element of MVC (keep in mind, these do not go in the order that they communicate in):<br />
&nbsp; Model:  The model is the code base of the application. For example, a calculator's model would be the class that handles operations such as multiplication, division, and more complex things if it was needed. Keep in mind, the model should <em>never</em> interact with the interface or the user directly. This kills the whole system. It <em>can</em>, however, send messages to the controller about what the results of an operation are, and the controller can send orders to it.<br />
&nbsp; View:  This is the interface that the user interacts with or sees. In our calculator example, this would be the actual window with buttons and a numerical display area. The view can send messages to the controller about what the user is doing, but it cannot talk directly to the model. Again, this kills the whole system.<br />
&nbsp; Controller:  This is a relay station of sorts. The controller takes actions sent by the view (from the user), and tells the model what to do. The model then sends back whatever data should be displayed to the user, and from there, the controller can tell the view to display it.<br /><br />
I know this all may seem fairly complicated, but if you look at any well-known open-source Cocoa project, you'll see that this is the accepted way of organizing your code. You'll do fine with it as long as you remember that the key is to separate the brains of the application from the interface that the user sees.<br /><br />

This tutorial was written for a new developer tutorial site, which has yet to be officially launched. This post will be updated once it has launched. Until then, please comment and critique! -Carter
