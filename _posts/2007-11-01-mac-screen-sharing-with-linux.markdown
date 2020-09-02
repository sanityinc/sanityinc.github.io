---
layout: post
title: "How to use OS X Leopard screen sharing with a Linux machine"
date: 2007-11-01
comments: true
categories: [Mac, Linux, OSX]
---

Apple's brand new Leopard version of OS X includes handy support for
connecting to shared remote screens right from the Finder.  The
intention was to connect to other Macs, but with a bit of tweaking you
can also connect to VNC servers running on Linux machines with the
same ease.

<!-- more -->

### Bonjour, Penguin!

In the new "Shared" section of the Finder's sidebar, the listed
servers are actually those that advertise interesting services on the
local network via [Bonjour](http://apple.com/bonjour) (a.k.a. ZeroConf
or mDNS).

My home Linux server (running Debian unstable) was advertising its AFP
network file volumes using ZeroConf thanks to a bit of prior
[Avahi](http://avahi.org/) configuration, so it showed up
automatically in my Leopard Finder.

I run a VNC server on that Linux machine, which happens to listen on
port 5901; it's started with the following command line:

```
tightvncserver -geometry 1024x700 -depth 24 :1
```

(The port number is 5900 plus the display number -- here 1.)

For the "Share Screen..." button to magically appear, I needed to tell
Avahi on the Linux machine advertise the VNC server, by adding the
file `/etc/avahi/services/rfb.service`, with contents as follows:

```xml
<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_rfb._tcp</type><port>5901</port>
  </service>
</service-group>
```

Avahi automatically detected the new service descriptor, and the
machine (called "inspiration") showed up in my Finder instantly:

![Finder displaying Linux machine in Shared section of sidebar, with Share Screen button enabled](/images/linux-screen-sharing-1.png)

(Aside: my guess is that the "Connection Failed" text is because the
Linux machine, unlike Leopard Macs, has no Guest account -- Leopard
appears to try connecting to file servers as Guest automatically.)

### Trying the magic button

Clicking on "Share Screen..." now brings up the swanky new Screen
Sharing application, which first prompts me to enter the vncserver
password, and then displays the following warning:

![Warning when connecting to a Linux VNC server from Finder](/images/linux-screen-sharing-2.png)

(As far as I know, no Linux VNC server software supports the keystroke
encryption that Screen Sharing would like to use.  Changing the
preference mentioned in the dialog also didn't help, even though the
Linux machine runs an ssh server and advertises it via Bonjour.)

Clicking "Connect" brings up my Linux desktop, running KDE:

![Connected to a Linux VNC server](/images/linux-screen-sharing-3.png)

This is all very convenient!

### Connecting to non-VNC Linux desktops

My Linux server is headless, and doesn't run a regular X server
connected to a monitor via a video card.  If your Linux server does
not run vncserver, and instead is plugged into a monitor, you should
still be able to connect; KDE has built-in support for screen sharing,
so it should be a simple matter to advertise the shared screen as
described above. (Port numbers may differ in that case.)
