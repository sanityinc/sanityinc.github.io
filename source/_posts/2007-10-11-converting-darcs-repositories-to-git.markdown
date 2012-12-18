---
layout: post
title: "How to make a git mirror of a darcs repository"
date: 2007-10-11
comments: true
categories: [Darcs, Git]
---

In this article I discuss techniques for migrating source code repositories from darcs to git.  I describe two approaches that failed for me, and introduce a new tool that I was able to use successfully with my own projects, and that can be used to create git mirrors of active darcs repositories.

<!-- more -->

### Background

I've been a big fan of [darcs](http://darcs.net) for over two years,
and have used it exclusively for my personal projects. However, in
recent times I have been increasingly drawn in by the community and
toolset that is growing around [git](http://git.or.cz/), and I've
naturally wanted to migrate some of my darcs repositories to git.

### darcs2git

The first tool I tried,
[darcs2git](http://repo.or.cz/w/darcs2git.git), uses a low-level git
component called git-fast-import to efficiently slurp data into git,
but when I tried to use it with the latest git at the time of writing,
git-fast-import choked on the binary data passed to it by
darcs2git. Game over.

### Tailor

[Tailor](http://progetti.arstecnica.it/tailor/), the Swiss Army Knife
of inter-VCS synchronisation, has helped me several times in the past
to migrate 80% of one VCS' contents into a new VCS-*du-jour*,
ultimately leading me to abandon it or file bug reports. Your mileage
might vary, depending on the source and target VCSes you try it with.

The key to `tailor`'s versatility is also its Achilles heel - it has a
standardised notion of a changeset, into which intermediate form every
source changeset is transformed. This notional changeset can contain
renames of files and directories, additions, deletions of files, and
suchlike.

When I tried to use `tailor` to convert my darcs repos to git, it became
stuck on certain changesets, apparently due to it misunderstanding some
of the move/rename cases in the source darcs changesets, and therefore
being unable to replay them into the working copy it uses for migration.

### A new approach

I decided to write my own naïve conversion script, which would
initialize a dual darcs/git repository in a working directory set aside
for migration, then gradually pull changes from a source darcs repo and
record each changeset wholesale into the git repository.

Using tricks from `darcs2git`, `tailor` and `git-svn`, I was able to do this
pretty easily, and my script even supports incremental importing from an
active darcs repository, which would allow it to be used for maintaining
public git mirrors of darcs repositories.

Unoriginally dubbed `darcs-to-git`, and written in
[ruby](http://www.ruby-lang.org/en/), the code can be found (and
tracked) here:

[http://git.sanityinc.com/darcs-to-git.git](http://git.sanityinc.com/?p=darcs-to-git.git)

`darcs-to-git` inserts tags into the comments of the git commits it
produces, containing the globally unique darcs patch ID from which the
commit originated. Having seen this technique used by the excellent
`git-svn`, this seemed the neatest approach for making incremental
migration of new darcs patches possible.

### Branches, and multiple source darcs repositories

`darcs-to-git` can only import changesets from a *single* darcs
repository, which essentially means there is no support for importing
the implicit branching that results from darcs' "cherry-picking" nature.
It should be possible to add such support, however.

Each darcs repository is essentially a unique branch, consisting of a
dependency-ordered bag of changesets that individually may or may not
appear in other darcs repositories. By comparing the patch list of two
darcs repositories starting with their earliest (common) revision, it
should be possible to determine the points at which to create git
branches, and use `git-merge` and/or `git-cherry-pick` to propagate later
common patches between branches.

Patches to `darcs-to-git` for this or any other worthwhile purpose are
welcome.

### Further reading

- [darcs-to-git repository](http://git.sanityinc.com/?p=darcs-to-git.git)
- [darcs](http://darcs.net/)
- [git](http://git.or.cz/)
- [This site](http://www.sanityinc.com/) -- why not
    [subscribe to future articles?](http://www.sanityinc.com/rss.xml)

