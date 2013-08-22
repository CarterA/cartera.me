# Balloon Satellite Project #

What was the coolest thing you did last month? Launch anything into near-space? If not, you might find this cool.

[![Ascent](/images/posts/2012-05-07-balloon-satellite-project/ascent.jpg)](http://www.flickr.com/photos/carterallen/7077631611)

This past semester, I worked as the lead software and electrical engineer on a small team of students to create a payload for a [high-altitude balloon satellite](http://en.wikipedia.org/wiki/High-altitude_balloon). The payload we constructed is a small [foam core](http://en.wikipedia.org/wiki/Foamcore) box, lined with closed-cell foam insulation. The box was closed and largely held together by a combination of hot glue and aluminum tape. Here is the payload, sitting on my desk, the night before the launch:  

[![Ascent](/images/posts/2012-05-07-balloon-satellite-project/payload-exterior.jpg)](http://www.flickr.com/photos/carterallen/6948948336)

It had no idea what was in store.  

### Design ###

Let's go back a bit: design for the payload began in mid-February of 2012. We threw out many ideas for what would go inside the box, and enjoyed coming up with ways to use the grant money we had been given (side note: I'm kidding here. We were very conscious of the budget we were given. No judging.) While the original list was a bit far-fetched, we settled on a set of items that was a bit intimidating:

- Infrared camera
- Standard still camera (we used a GoPro HD Hero 2)
- Geiger Counter
- "9 Degrees of Freedom" set of motion sensors (3-axis accelerometer, 3-axis gyroscope, and 3-axis magnetometer)
- Barometric pressure sensor (helpful for estimating altitude)
- Temperature and humidity sensors

Data from all of these things needed to be recorded somehow. With the exception of the GoPro camera, everything required another component for logging data. We also needed to have batteries to power everything, and some sort of heating system to keep all the electronics running inside their operating temperature range (it can get pretty cold up there!) At this point, our plan was looking a bit ambitious to me.  

### Subsystems ###

We broke the whole project into several subsystems, and while I was originally going to only handle one of them, I ended up being involved in almost every subproject.

#### Infrared Camera ####

The infrared camera was the subsystem that I helped with the least. IR cameras are very expensive, and the only reason we were able to get one was through a connection at the employer of one of our teammates. He handled almost all of the work, although I did end up wiring the batteries to power it. A small DVR was supposed to record video from the IR camera to an SD card, though this was one of the two subsystems that didn't perform perfectly in the flight.  

#### Geiger Counter ####

I cannot fully express how much pain the Geiger counter caused me. It was not a physical pain (although I did burn myself a few times with the soldering iron), but a never-ending psychological assault that continued until the moment the box was sealed. On top of all the trouble it caused leading up to the launch, the counter failed to record data for more than 30 minutes (of the almost 2 hour flight).