Hey guys I might need some help with this. 

Basically, I have one of these: http://www.oomlout.co.uk/8-x-8-bicolour-led-matrix-p-233.html?zenid=a0355ee4bdc4f72484b868c90532c6e5

It's an 8x8 display matrix thing.

And I want to hook it up to a web page full of checkboxes. The idea is that anyone can visit that web page and there will be a grid of checkboxes so that they can control the display in real time!

I'll be using Pusher in order to do all this in real time.

This repo is split into 3 sections:

- Rails - this is the rails backend, that orchestrates communication between connected clients and pusher

- Mac - the mac software that receives events from pusher, and sends display data to the arduino over serial

- Arduino - receives display data from serial port and displays it on the display. Also need to hook up the actual electronic components required (I have these)