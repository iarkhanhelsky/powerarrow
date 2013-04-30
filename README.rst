Awesome Powerarrow theme for 3.5
================================

:Original Author: https://github.com/romockee/powerarrow

This is my fork of Romockee's Powerarrow theme, implemented
for Awesome-WM 3.5
This project is now in a stage where
80% of the widgets work and I am still working on fixing up
the libraries.


Notes
-----

You will need this updated library of "blingbling" for some
of the Awesome-WM widgets:
https://github.com/cedlemo/blingbling

Lua-oocairo:
https://aur.archlinux.org/packages/lua-oocairo/

udisks-glue-git:
https://github.com/fernandotcl/udisks-glue

**Beware, some of the hotkeys/key-bindings are from my rc.lua, so if something that you are used to pressing doesn't work, check my global keys**


What works in my version: so far
------------------------

- The layout in general (powerline)
- Clock
- Wireless icon and data sent/received indicator
- Battery
- Volume
- CPU widget
- MEM widget
- Mutt Mail widget

Some differences:
----------------

- Took out the binary clock, due to the fact that it takes me way to long to read.
- Added on a clock widget and icon
- Added a "netstat" drop down menu using the 'blingbling' library to indicate what processes are currently using the Internet
- Volume icon instead of the core temperature.
- Working wifi-signal strength indicator.  The bars now go
  up or down, depending on your computers wifi signal strength, rather than a static icon that doesn't change (see screenshots for example)

Screenshots:
-------------

.. image:: http://i.imgur.com/oqBm8Qf.png
- wifi signal low
.. image:: http://i.imgur.com/nb0dBOx.png
- wifi signal medium

.. image:: http://i.imgur.com/9WWpTXL.jpg
- The desktop so far
