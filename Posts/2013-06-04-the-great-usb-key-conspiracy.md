# The Great USB Key Conspiracy #

After being admitted to the [University of Southern California](http://usc.edu), I began receiving quite a bit of mail from their various departments. The Viterbi School of Engineering, where I will be attending school next year, was the first to send me a USB key, which I promptly ignored. Assuming it was just a flash drive full of documents, I cast it aside like I had with almost every other piece of cardinal-and-gold paper that had arrived in my mailbox. Little did I know that the key was just the beginning of a vast conspiracy. What followed was the unraveling of a direct-mail tale of corruption and deceit, a story that exposed the seedy underbelly of USB-based correspondence.  

<img src="/images/posts/2013-05-27-the-great-usb-key-conspiracy/attack-vector-exterior.jpg" alt="The unassuming attack vector, a cardinal-and-gold USB key" width=300 style="float: left; margin-right: 25px;">

It wasn't until I received the second USB key, this time from the Student Health Center, that I became curious as to why they were sending USB keys instead of traditional correspondence. I plugged the key into my computer, and waited. After a momentary delay, I heard three "thunks" from my speakers (the quintessential "you can't do that!" Macintosh sound), before my dock popped up, the Safari icon dimmed, Safari came to the front, the URL for the health services website was entered into the address bar one letter at a time, and the site was loaded.  

While most people would simply cock their head momentarily before smiling and starting to use the website, my immediate reaction was a potent mixture of terror and morbid curiosity. Considering the lack of [U3](http://en.wikipedia.org/wiki/U3) and [autorun.inf](http://en.wikipedia.org/wiki/Autorun.inf) support on OS X (which is a Good Thing™), I couldn't understand how the little USB stick was capable of controlling my computer in such a way.  

I jumped over to Terminal, where I ran:

    sudo fs_usage | grep \"/dev\"

That command quickly showed me that the mysterious USB key wasn't being mounted as a volume at all. How, then, could it be manipulating my computer? I considered the facts. There is no way to run arbitrary code, without user intervention, from a USB device on OS X. Lacking such a vector, how would *I* go about opening a URL on an unknown computer?  

The answer was hidden in the *way* that the key had navigated to the URL. If the device was capable of executing code, it would simply trigger OS X's native URL loading system, which would open the webpage in the default browser without needing to manually switch apps and type the URL one character at a time. And that was the key. *One character at a time.*  

The USB key was masquerading as a keyboard.  

Once I knew what it was doing, the specifics became trivial. [Control-Fn-F3](http://osxdaily.com/2012/05/08/navigate-the-dock-in-mac-os-x-with-these-8-keyboard-shortcuts/) opens the dock with keyboard navigation enabled, entering "Safari" selects the browser, Command-L selects the address bar, and from there all that needs to be done is enter the URL.  

Knowing how the USB key was performing its magic only led me to bigger questions. Who had designed it? Was the security community aware of the possibility of similar devices being weaponized? And perhaps most importantly, why would two different departments at USC choose to send these little devils instead of just *writing the damn URL on a postcard*?  

Not knowing what else to do, I took apart the key. Prying open the metal casing was easy, albeit destructive, and inside was a very simple circuit board. Unfortunately, the interesting part of the board – the integrated circuit in the center – was encased in a hard epoxy shell. The practice of covering IC's with epoxy [is common](http://en.wikipedia.org/wiki/Epoxy#Electrical_systems_and_electronics) in mass-production of inexpensive electronics, and meant that I couldn't pull any part numbers off of the board. So that was a dead end.  

At a loss, I turned to Google. To my surprise (given the conspiratorial nature of the entire situation), I found the answer rather quickly. The company, which will remain nameless for my own protection, sold products that clearly matched the key on my desk. Sadly, I found the website to be unsurprisingly devoid of details. With no links to buy keys (for comparison, of course), I was once again at a dead end. That is, until I clicked over to the company's LinkedIn page. In what may be the most legitimate use of LinkedIn to date, I found my suspect. The fact that he was the founder of the company wasn't what interested me. No, the important piece came under the "Education" section: he attended the University of Southern California.  

That was when I realized that I had just blown the case wide open. USC's use of the USB keys was nothing more than a carefully concealed conspiracy to funnel untold millions into the pockets of its alumni. With all of this information in hand, I decided to test out my theory on my father. After a lot of handwaving and a heavy dose of hyperbole, I sat back in my chair and waited for his response. After a beat, he shrugged, and replied:  

*"That's capitalism."*