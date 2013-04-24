---
layout: post
title: "Init scripts considered harmful"
date: 2007-11-11
comments: true
categories: [Linux, Mac, OSX, Rails, Unix]
---

Tired of PID files, needing root access, and writing init scripts just
to have your UNIX apps start when your server boots?  Want a simpler,
better alternative that will also restart them if they crash?  If so,
then read this quick-start introduction to process supervision with
runit/daemontools.

<!-- more -->

### Background

Classic init scripts, e.g. `/etc/init.d/apache`, are widely used for
starting processes at system boot time, when they are executed by
`init`.  Sadly, init scripts are cumbersome and error-prone to write,
they must typically be edited and run as root, and the processes they
launch do not get restarted automatically if they crash.

In an alternative scheme called "process supervision", each important
process is looked after by a tiny supervising process, which deals
with starting and stopping the important process on request, and
re-starting it when it exits unexpectedly.  Those supervising
processes are in turn reliably supervised by other supervising
processes, in a hierarchy extending up to the "master" UNIX process
with PID 1, typically `init`.

(The process supervision pattern is long-established, and is even
built into the programming language [Erlang](http://www.erlang.org/),
which is used for ultra-reliable telecoms applications.)

It's possible to replace all init scripts with supervised processes,
but not necessary.  As application developers we can get most of the
benefits simply by using process supervision to run our applications
as non-root users, leaving the init scripts in place for system
services.

### Daemontools and runit

Dan Bernstein (of qmail fame) wrote the seminal process supervision
toolkit [daemontools](http://cr.yp.to/daemontools.html), which is a
beautifully-designed set of small, ultra-reliable and
highly-specialised programs that cooperate in the UNIX tradition to
manage process supervision trees.

[Runit](http://smarden.org/runit/) is a more conveniently licensed and
more actively maintained reimplementation of daemontools, written by
Gerrit Pape.

For the purposes of this article I'll use runit. It is widely
available, and I personally use the packages for
[Debian](http://www.debian.org/) and
[Homebrew](https://github.com/mxcl/homebrew/).

### Service directories and scripts

In runit parlance a "service" is simply a directory containing a 'run'
script.  More on those later.

There are just two key programs in runit.  Firstly, `runsv` supervises
the process for an individual service.  Service directories themselves
sit inside a containing directory, and the `runsvdir` program
supervises that directory, running one child `runsv` process for the
service in each subdirectory.  Out of the box on Debian, for example,
an instance of `runsvdir` supervises services in subdirectories of
`/var/service/`.

Let's add a simple play service, as root for now:

```
# mkdir /etc/runit/sleeper
```

Now we create a run script for the service; run scripts should not
fork, exit or maintain their own PID files.  We'll use a 5-minute
`sleep` command to simulate a long-running service that occasionally
crashes.  We create `/etc/runit/sleeper/run` as follows:

```bash
#!/bin/sh -e
exec sleep 300
```

And we make it executable:

```
# chmod +x /etc/runit/sleeper/run
```

Remember that runsvdir is actually watching `/var/service/` -- watch
what happens when we make our service definition appear there:

```bash
# ln -s /etc/runit/sleeper /var/service/sleeper
```

Now `pstree` shows us this:

```
init-+-atd
     |-cron
 .........
     |-runsvdir---runsv---sleep
     `-sshd
```

Yes, `runsvdir` noticed the new service, and started running it with its own `runsv`.

To stop and start the service, we talk to that `runsv` process using the `sv` utility:

```
# sv status sleeper
run: sleeper: (pid 32493) 147s
# sv stop sleeper
ok: down: sleeper: 1s, normally up
# sv status sleeper
down: sleeper: 4s, normally up
```

Note that if we tell the service to stop, it stays stopped.

However, when the service is running then `runsv` will attempt to keep
it running; if the service exits unexpectedly, then `runsv` will restart
it automatically within a few seconds:

```
# sv start sleeper
ok: run: sleeper: (pid 32627) 0s
# sv restart sleeper
ok: run: sleeper: (pid 32629) 0s
# killall sleep
# sv status sleeper
run: sleeper: (pid 32631) 4s
```

Our `sleeper` service will be started by `runsvdir` when the operating system starts up.  (`runsvdir` itself is typically run from - and supervised reliably by - `init`.)

If we remove the `sleeper` symlink from `/var/service/`, then the
`sleeper` process will be stopped and removed from the supervision
tree.

### Why the symlink?

Keeping our service definitions in one directory (`/etc/runit/`) lets us
start them manually in order to debug our `run` scripts, before
putting the services under the control of runit by adding symlinks
under `/var/service`.

### Reliable services for unprivileged users

Using this machinery, we can arrange for non-root users to have
supervised services too.  We simply give our application user (login
`appuser`) a `~/service` directory, and then set up a service under
`/var/service` that will reliably run an instance of `runsvdir` for that
directory with `appuser`'s privileges:

```
# mkdir /etc/service/appuser
```

The `run` script at `/etc/service/appuser/run` looks like this:

```bash
!/bin/sh -e
exec 2>&1 exec chpst -u appuser runsvdir /home/appuser/service 'log: ...........................................................................................................................................................................................................................................................................................................................................................................................................'
```

Now `appuser` can create (or symlink) services under
`~appuser/service`, and they will be managed in the same reliable
manner as our global `sleeper` service earlier.

Note that `appuser` must pass the full path to his services when
controlling them using `sv`, since `sv` otherwise assumes that service
names correspond to service directories under `/var/service`:

```bash
% sv restart ~/service/myapplication
```

The following is an example process tree on a server running three
applications, each as its own user with a `~/service` directory:

```
init-+-atd
     |-lighttpd
  .......
     |-postgres---11*[postgres]
     |-runsvdir-+-runsv---runsvdir-+-2*[runsv---ruby---{ruby}]
     |          |                  |-3*[runsv---mongrel_rails---{mongrel_rails}]
     |          |                  `-runsv---pen
     |          |-runsv---runsvdir-+-runsv---ruby---{ruby}
     |          |                  |-5*[runsv---mongrel_rails---{mongrel_rails}]
     |          |                  `-runsv---pen
     |          `-runsv---runsvdir-+-runsv---mongrel_rails---{mongrel_rails}
     |                             `-runsv---pen
     `-sshd
```

### Debugging service definitions

If `runsvdir` is unable to execute a `run` script for some reason, then
by default it will write log messages to its process title: look at
the output of `ps aux` for a clue (this is the reason for the long
`......` line above).  If possible, try starting your run script by
hand before symlinking the service directory into the location
runsvdir is watching.

### Other capabilities

Runit can do much more than I have presented here; it can manage
reliable logging of `stdout`/`stderr` output as an alternative to (or
in addition to) syslog; take a look at `svlogd`.  Setting up logging can
make it much easier to figure out why services don't seem to be
starting correctly.

Simple mechanisms also exist for specifying dependencies between
services, such that one will not start before another is up and
running.  That's typically less an issue for application
administrators than it is for system administrators.

### Under the covers

The design of runit is full of elegant touches; for example, `runsv`
creates a `supervision` subdirectory of the service directory it is
supervising.  In that directory it writes a PID file and a named pipe
connected to itself.  `sv`then simply writes rudimentary commands to
the pipe, to which `runsv` then reacts.

Monitoring tools such as monit can be easily configured to report on
the status of service processes by pointing them at the PID files.

### Unprivileged processes, privileged ports

Sometimes people run applications as root simply because they need to
listen on privileged ports (ie. ports below 1024).  If you need such a
port, you can still run your application as an unprivileged service;
consider using iptables or a tcp proxy like [pen](http://siag.nu/pen/)
to proxy that port through to your unprivileged runit services
listening on unprivileged ports.

### More

If you found this article helpful, or want to read my forthcoming
article about reliably running
[Ruby on Rails](http://www.rubyonrails.org/) applications using runit,
please [subscribe to my feed](http://www.sanityinc.com/rss.xml).
