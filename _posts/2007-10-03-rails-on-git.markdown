---
layout: post
title: "Rails on Git: How much hype fits in 9MB?"
date: 2007-10-03
comments: true
categories: [Rails, Git, Subversion]
---

[Ruby On Rails](https://www.rubyonrails.org/) has a Subversion
repository with
[over 7500 commits](https://dev.rubyonrails.org/timeline) at the time
of writing. In this article I show how you can use
[Git](https://git.or.cz) to have a full local copy of the repository in
9MB, and use it to track upstream changes.

In a subsequent article I will show you how to use such a repository
to easily maintain Rails patches for the six months it takes you to
get them accepted into Core (wink).

<!-- more -->

### Background

Git is a revision control system that is *distributed*, which means that
every developer using Git gets to be the ruling dictator of his own
distinct code repository. With a distributed RCS, a central "master"
repository is an optional result of a consensus decision, and not a
technical requirement.

Having a full local repository lets you work off-line, branch and
merge freely, and check in regularly without being a project member.

### Mirroring subversion repositories: git-svn

Git ships with a nifty tool called `git-svn`, which can pull and push
changesets between a subversion repository and a git repository,
maintaining tag, branch and author information.

After reading a
[helpful article](https://utsl.gen.nz/talks/git-svn/intro.html) I used
git-svn to make a mirror of the Rails subversion repository. That step
took many hours, so I've set up my mirror to update itself regularly
throughout the day, and published it at the following Git URL:

```
git://git.sanityinc.com/rails.git
```

More on how to use that URL later.

### What you will need

Make sure you have `git` installed, with `svn` support.  (To follow
this article, you don't need the `svn` support, but you'll no doubt
want to play with `git-svn` yourself.)  In most Linuxes, the package
to install is called "git-core".  On a Mac, if you value your time you
will use the [MacPorts](https://www.macports.org/) package
with 'svn' variant enabled:

```bash
% sudo port install git-core +svn +doc
```

### Make a local clone of the repository

You can clone my Git mirror of the Rails repository using `git-clone`:

```bash
% git-clone git://git.sanityinc.com/rails.git
Initialized empty Git repository in /tmp/rails/.git/
remote: Generating pack...
remote: Counting objects: 6041
Done counting 59416 objects.
remote: Deltifying 59416 objects...
 100% (59416/59416) done16) done
Indexing 59416 objects...
remote: Total 59416 (delta 45829), reused 58267 (delta 45039)
 100% (59416/59416) done
Resolving 45829 deltas...
 100% (45829/45829) done
```

The newly-created `rails` directory contains **every changeset in
Rails' history, all stored in only 9.2MB of packed Git data**:

```
% cd rails % du -hs .git/objects
9.2M    .git/objects
```

This magic is possible due to Git's delta compression.  Note that a
plain `vendor/rails` directory alone weighs in at over 8MB.

Here are all the branches:

```
% git-branch -a
* master
  origin/1-1-stable
  origin/1-2-pre-release
  origin/1-2-stable
  origin/HEAD
  origin/cap2-on-netssh2
  origin/cap2-on-netssh2@2073
  origin/cap2-on-netssh2@3784
  origin/cap2-on-netssh2@7243
  origin/capistrano_1-x-stable
  origin/capistrano_1-x-stable@2073
  origin/capistrano_1-x-stable@3784
  origin/capistrano_1-x-stable@6222
  origin/master
  origin/p2
  origin/performance
  origin/restful_aws
  origin/restful_aws@1324
  origin/restful_aws@668
  origin/routing
  origin/stable
  origin/trunk
```

Note that the default branch is `master`, which corresponds to `origin/trunk` - Rails "edge".

You can trivially switch the working copy in the current directory to another branch, such as the Rails `stable` branch:

```
% git-checkout -b stable origin/stable
Branch stable set up to track remote branch refs/remotes/origin/stable.
Switched to a new branch "stable"
</blockcode>
(It's considered bad practice to check out remote branches directly, so here we made a local 'stable' branch that tracks 'origin/stable'.)

'git-log' gives us the commit history for the current branch:
<blockcode>
% git-log
commit 1f5a5285c45caf49261ded485aa9994296e0305e
Author: ulysses <ulysses@5ecf4fe2-1ee6-0310-87b1-e25e094e27de>
Date:   Thu Aug 10 17:13:55 2006 +0000

    Can't use controller_path due to Admin model and Admin::UserController case

    git-svn-id: https://svn.rubyonrails.org/rails/branches/stable@4750 5ecf4fe2-1ee6-0310-87b1-e25e094e27de
...
```

Note the embedded subversion revision, `@4750`.

You can browse the history of the current branch using the `gitk` GUI.

### Keeping your mirror up to date

You'll want to periodically pull new changes from the Rails repository into your local repository.  Use 'git-pull' for this:

```
% git-pull
remote: Generating pack...
remote: Done counting 23 objects.
remote: Result has 15 objects.
remote: Deltifying 15 objects...
remote:  100% (15/15) done
remote: Total 15 (delta 13), reused 0 (delta 0)
Unpacking 15 objects...
 100% (15/15) done
* refs/remotes/origin/trunk: fast forward to branch 'trunk' of git://git.sanityinc.com/rails
  old..new: 258ae9d..6bf2bef
Already up-to-date.
```

### Making changes locally

With a little git knowledge, you can commit changes into your local
repository, getting git to do the magic of merging upstream changes.

If you want to contribute patches back to Rails, you can use git to
maintain them; git can regenerate your patches automatically as the
surrounding Rails code changes. A follow-up article on this site will
describe how to do this.

### Further reading

- [Git documentation](https://git.or.cz/gitwiki/GitDocumentation)
- This site -- why not
    [subscribe to future articles](/)?

**Update: I've set up gitweb, so you can
[browse the Rails git mirror here](https://git.sanityinc.com/?p=rails.git;a=summary).**

**Further update: my mirror will be discontinued now that Rails
development has [switched to Git](https://github.com/rails/rails)**
