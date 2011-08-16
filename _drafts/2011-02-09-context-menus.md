--- 
layout: post
title: Context Menus and How to Use Them Properly
---

Contextual menus (or just "Context" menus) are an integral part of most desktop interfaces. They're definitely on their way out as move towards direct interaction (via gestures), but they will always have a special place in my heart. As such, I hate to see them used so poorly in many cases.  

The purpose of a context menu is simple:  provide access to a subset of commands that are relevant to whatever context you're in. If you right-click (or control-click, or two-finger-click, or whatever) on this text, you'll almost definitely see a context menu. If you're in Safari, it'll give you options to reload the page, view the source code that generates it, and a few other useful functions. If you make sure to click on an actual word, then you'll also see the system-wide text context menu functions:  things like dictionary lookup and searching.  

**This all makes sense so far.** Now I'd like to turn the focus to the Dock in Snow Leopard. Right-clicking a Dock icon produces a black context menu which by default looks like this:  

![The context menu of an icon in the Snow Leopard Dock, with the options submenu opened.](/images/posts/2011-02-09-context-menus/dock-context-menu.png)

Take a look at that picture. Now take another look. What parts of it make sense? Let's just take it from bottom to top.

- **Quit**:  This one makes sense. It is relevant to the context it is in (the dock icon represents the application).
- **Show**:  Same as quit - makes sense.
- **Options**:
    - **Keep in Dock**:  This is an option, so it makes sense.
    - **Open at Login**:  Yep, it's an option.
    - **Show in Finder**:  Sounds like an option...hey wait a second! That's not an option, it's an action! Not only is it not an option, but the wording is inconsistent with the rest of the operating system. The accepted name of an action that opens a file in Finder is "Reveal in Finder", not "Show in Finder".

The other issue here is that if you remove "Show in Finder" because it isn't an option, then you have an added level of submenus just for two more menus. That isn't very efficient, so it would then be best to just flatten the hierarchy and put a separator in.  

Overall, the dock menu is almost right, but because of the mistake of calling "Show in Finder" an option and thus adding another level of menus, it has become overly complicated and confusing. Of course, developers are also free to add as much as they want to the Dock context menu, so they usually get quite a bit more complex.  