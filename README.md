## python-R

This is a Cython package designed to allow running R code from Python.

**09.05.2013 WORKING BUILD v0.1 RELEASED!**

### Dependencies

To make python-R run correctly, ensure you've installed Rcpp and RInside packages.
A common way to do that is to run R (`sudo R` to install into Linux system directories)
and type in

    > install.packages("Rcpp")
    > install.packages("RInside")

You'll also need NumPy installed (`sudo apt-get install python-numpy` in Debian/Ubuntu).

### Downloading and Building

To download the sources, simply type

    $ git clone http://github.com/Saluev/python-R.git

in your favorite directory if you've got `git` installed. Otherwise, you can just click **ZIP** button
on [this page](http://github.com/Saluev/python-R).

To compile, just `cd` into the folder with sources and run

    $ sudo python setup.py install

After that the package will be available with Python's `import libR`.

Some examples or tests may (probably) be found in `examples/` directory.
A simple program that invokes R to get normally distributed random vector can look like

```python
import libR
R = libR.pyRInside()
nvec = R.parseEval("rnorm(100, 0.0)")
```
