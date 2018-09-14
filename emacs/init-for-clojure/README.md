# Clojure-friendly emacs config

This is an updated Clojure-friendly emacs config based
on the [one](https://github.com/flyingmachine/emacs-for-clojure/archive/book1.zip)
used in [Clojure for the Brave and True](http://www.braveclojure.com/).
Main changes are to update [CIDER](https://github.com/clojure-emacs/cider) version
and make default font more developer friendly.

## Installing

1. Close Emacs.
2. Delete and recreate `~/.emacs` or `~/.emacs.d` if they exist.
3. Create new `~/.emacs.d` directory.
4. Download this Emacs configuration into `~/.emacs.d` directory.

```
svn export https://github.com/almacro/snippets.git/trunk/emacs/init-for-clojure
```

5. Create the file `~/.lein/profiles.clj` and add this line to it:

```clojure
{:user {:plugins [[cider/cider-nrepl "0.8.2"]]}} 
```

Then open Emacs.

NOTE: Any .elc directories in this tree were compiled on Emacs25.
If you use Emacs24, just stop Emacs, delete the compiled files, and restart Emacs:

```
find ~/.emacs.d -name "*.elc" | xargs rm
```

This recommendation was gleaned from [here](https://github.com/syl20bnr/spacemacs/issues/3129) and [here](https://github.com/clojure-emacs/cider/issues/1556#issuecomment-182920808).
