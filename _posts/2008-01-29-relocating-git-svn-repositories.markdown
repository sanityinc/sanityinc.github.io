---
layout: post
title: "Relocating git-svn repositories"
date: 2008-01-29
comments: true
categories: [Git, Subversion]
---

If you use the amazing git-svn to work in a civilised manner with a
subversion repository, you may have trouble if the subversion
repository is relocated, ie. has its access URL change.  This article
describes an approach for handling this situation, which git-svn does
not directly support.

<!-- more -->

### git-svn relies heavily on the SVN URL

Every svn commit that is found in a git-svn repo has a 'git-svn-id'
tag associated with it, and which is included in its commit message.
This tag is built partly from the URL of the svn repository from which
the commit came.

The same physical svn repository leads to different git-svn clones if
it is served via different URLs.  Relocating is therefore a problem,
and is not - as far as I am aware - supported in any fashion by
git-svn.  That seems a reasonable decision, since the changes in a
codebase managed by git-svn are expected to be coordinated via SVN, so
the git-svn repositories should be largely disposable.

However, if a user has local changes in his git-svn clone that he does
not wish to lose, he must find a way to preserve those changes in his
git-svn repository after the svn repository has been relocated.

### An approach that worked for me

The svn repository of a large codebase upon which I work was recently
relocated, and I wanted to keep working with my git-svn clone.  In
particular, my git-svn clone had a few local branches corresponding to
pending work that was not yet committed to svn; I wanted to preserve
the content of these branches.

I achieved the desired effect by following these steps:

1.  Create a new git-svn clone from the new svn URL
2.  Copy local branches from the old git-svn clone to the new clone


Creating a new git-svn clone should be familiar to any reader to which
this article is relevant.  Copying local branches is more involved...

### Copying local branches between git-svn repositories

Let's walk through the process of copying local git branches between
two git-svn clones of the same svn repository.

Starting in the 'old' repository, we find local branches.  Those are the branches where the head is not in svn:

```bash
% for b in `git-branch -a|cut -c3-`; do git-log -1 $b|grep git-svn-id: >/dev/null || echo $b; done
globalize-upgrade
```

Just one branch.  Let's see how to recreate that branch and its contents in the new clone.

We'll need to find where the branch started.  Let's find the last
revision on the branch that had a git-svn-id:

```bash
% git-rev-list -n1 globalize-upgrade --grep=git-svn-id:
e443c92bd2c806d3d95701d0a69c4c855d10342a
```

It seems safe at this point to assume that this was the branch point.
We can find the svn revision as follows:

```bash
% git-svn find-rev e443c92bd2c806d3d95701d0a69c4c855d10342a
7783
```

Now we need to find that revision (7783) in the new git-svn clone:

```bash
% (cd ../new-clone && git-rev-list master --grep='git-svn-id:.*@7783')
8884b812f9162f75107045e21ad615ff38cbaab6
```

Cool, so we create a branch at that point in the new repository:

```bash
% (cd ../new-clone && git-checkout -b globalize-upgrade 8884b812f9162f75107045e21ad615ff38cbaab6)
Switched to a new branch "globalize-upgrade"
```

And finally, we need to slurp all the non-SVN commits from the branch in the old repo into the new branch in the new repo.  The combination of git-format-patch and git-am are perfect for this:

```bash
% git-format-patch --stdout e443c92bd2c806d3d95701d0a69c4c855d10342a..globalize-upgrade|(cd ../iss-git2 && git-am)
```

Voilà! The local branch has now been copied and committed into the new git-svn clone repository.

### Wrapped up in a shell script

**Update: [Here's an updated script in Ruby](https://gist.github.com/591602) provided by Ed Ruder, which works with the current git as of Sept. 2010.**

Here's a shell script that I chose to name "git-svn-copy-local-branches":

```bash
#!/bin/sh -e
# Disclaimer: there's not much in the way of error-checking here.

SRC_REPO=$1/.git
DEST_REPO=$2/.git

if [ ! -d "$SRC_REPO" -o ! -d "$DEST_REPO" ]; then
  echo "usage: $0 src_repo dest_repo" >&2
  exit 2
fi

# Find branches where the head is not in svn:
function local_branches() {
  export GIT_DIR=$1
  for b in `git-branch|cut -c3-`; do
    git-log -1 $b|grep git-svn-id: >/dev/null || echo $b
  done
}

function newest_svn_commit_on_branch() {
  repo=$1
  branch=$2
  GIT_DIR=$repo git-rev-list -n1 $branch --grep=git-svn-id:
}

function find_svn_rev() {
  repo=$1
  rev=$2
  GIT_DIR=$repo git-rev-list master --grep="git-svn-id:.*@$rev"
}

for branch in `local_branches $SRC_REPO`; do
  echo "--------------------------------------------------"
  echo "Local branch: $branch"
  echo "--------------------------------------------------"
  src_branch_point=`newest_svn_commit_on_branch $SRC_REPO $branch`
  src_branch_point_svn_rev=`GIT_DIR=$SRC_REPO git-svn find-rev $src_branch_point`
  dest_branch_point=`find_svn_rev $DEST_REPO $src_branch_point_svn_rev`
  echo "- start: svn=$src_branch_point_svn_rev, src=$src_branch_point, dest=$dest_branch_point"

  GIT_DIR=$DEST_REPO git-checkout -b $branch $dest_branch_point
  GIT_DIR=$SRC_REPO git-format-patch --stdout $src_branch_point..$branch|(GIT_DIR=$DEST_REPO git-am)
done
```

### Conclusions

Thanks to the rich set of git commands, it's possible to easily graft branches between compatible trees of commits.  Using this technique, we can preserve our work even if we have to re-clone an svn repository.
