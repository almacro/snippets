# Clojure-friendly emacs config

This is an updated Clojure-friendly emacs config based
on the [one](https://github.com/flyingmachine/emacs-for-clojure/archive/book1.zip)
used in [Clojure for the Brave and True](http://www.braveclojure.com/).
Main changes are to update [CIDER](https://github.com/clojure-emacs/cider) version
and make default font more developer friendly.

## Installing

1. Close Emacs.
2. Delete `~/.emacs` or `~/.emacs.d` if they exist.
3. Download this Emacs configuration.

```
svn export https://github.com/almacro/snippets.git/trunk/emacs/init-for-clojure
```

4. Create the file `~/.lein/profiles.clj` and add this line to it:

```clojure
{:user {:plugins [[cider/cider-nrepl "0.8.2"]]}} 
```

Then open Emacs.
