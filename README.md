Stata-SVM
=========

This is a [Stata plugin](http://www.stata.com/plugins) wrapping [libsvm](http://www.csie.ntu.edu.tw/~cjlin/libsvm/)
to offer Support Vector Machine based algorithms, both regression and classification, to Stata users.

If you use this in a project, please cite it as:

> Guenther, Nick, and Matthias Schonlau. "Support vector machines." Stata Journal 16, no. 4 (December 23, 2016): 917-37. http://www.stata-journal.com/article.html?article=st0461. 


Originally written by [Nick Guenther](http://github.com/kousu) and [Professor Matthias Schonlau](http://www.schonlau.net).

Installation
------------

In Stata:
```
. net search svmachines
```
will let you find this wrapper. To install the currently published copy from the Stata archive, this means doing

```
. net sj 16-4
. net install st0461
```

But as it is only a wrapper, so you need to install [libsvm](http://www.csie.ntu.edu.tw/~cjlin/libsvm/) too:

### Windows

On Windows, libsvm is bundled with this package, because dependency tracking is too difficult on Windows, so there should be nothing for you to do.

### OS X

* macports: `port install libsvm` _OR_
* brew: `brew install libsvm`

### Unix

* Debian-derivatives: `apt-get install libsvm3`
* Arch: libsvm is [in the AUR](https://aur.archlinux.org/packages/libsvm/)
* Redhat/Fedora: `yum install libsvm` (**UNTESTED**)
* You can manually [download](http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/libsvm.cgi?+http://www.csie.ntu.edu.tw/~cjlin/libsvm+tar.gz) and follow the [build instructions](https://github.com/cjlin1/libsvm).

Alternate Installation
----------------------

If the published [Stata Journal](https://www.stata-journal.com/) [copy](https://www.stata-journal.com/software/sj16-4/st0461.pkg) isn't working for you, you can also install directly out of this repository. Get [svmachines.zip](svmachines.zip) get unzip it somewhere, say `/tmp/stata_install/` and make sure that creates `/tmp/stata_install/svmachines.pkg` as well as the folder `/tmp/stata_install/svmachines/`. Then, in Stata, do

```
. net use /tmp/stata_install
. net install svmachines
```

Usage
-----

See `help svmachines`
