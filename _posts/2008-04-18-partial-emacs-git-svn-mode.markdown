---
layout: post
title: "Part-way to an emacs git-svn mode"
date: 2008-04-18
comments: true
categories: [Emacs, Git, Subversion]
---

Interacting with git from within emacs is a pleasure, thanks to the
official git-mode and Leah Neukirchen's fantastic
[gitsum mode](http://leahneukirchen.org/blog/archive/2008/02/introducing-gitsum.html).
Here are some convenient bindings for running git-svn from emacs.

<!--more-->

```scheme
(require 'git)
(require 'ido)

(eval-after-load "compile"
  '(progn
     (mapcar (lambda (defn) (add-to-list 'compilation-error-regexp-alist-alist defn))
             (list '(git-svn-updated "^\t[A-Z]\t\\(.*\\)$" 1 nil nil 0 1)
                   '(git-svn-needs-update "^\\(.*\\): needs update$" 1 nil nil 2 1)))
     (mapcar (lambda (defn) (add-to-list 'compilation-error-regexp-alist defn))
             (list 'git-svn-updated 'git-svn-needs-update))))

(defun git-svn (dir)
  (interactive "DSelect directory: ")
  (let* ((default-directory (git-get-top-dir dir))
         (compilation-buffer-name-function (lambda (major-mode-name) "*git-svn*")))
    (compile (concat "git svn " (ido-completing-read "git-svn command: " (list "rebase" "dcommit" "log") nil t)))))
```

With the above code in your .emacs file, you can hit M-x, and type
`git-svn`.  You'll then be prompted for a git directory (just as for
git-status), and you'll get to choose between `rebase`, `dcommit` and
`log`.  Any filenames in the command output will be colorised and
hyperlinked.

At some later point I'd like to turn this into a full-fledged git-svn
mode, and hook it into git-status-mode, as Leah has done with
gitsum.

Watch this space!
