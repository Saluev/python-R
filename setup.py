import sys
import os
from distutils.core import setup
from distutils.extension import Extension

# we'd better have Cython installed, or it's a no-go
try:
    from Cython.Distutils import build_ext
    from Cython.Build import cythonize
except:
    print "You don't seem to have Cython installed. Please get a"
    print "copy from www.cython.org and install it"
    sys.exit(1)

try:
    paths = os.popen("R --no-save --slave < paths.R").read()
except:
    print "Encountered problems with R."
    print "Make sure you've installed R, Rcpp and RInside packages."
    sys.exit(2)

paths = paths.split("\n")
# a fragile line to get correct include paths
paths = [paths[0][:-1]] + [path[:-1] + "/include" for path in paths[1:-1]] # TODO: OS-dependent slash?..
print paths

src = ["libR.pyx", "libRaux.cpp"]
libR_ext = Extension("libR", src, language='c++', include_dirs=paths)

# finally, we can pass all this to distutils
extensions = [libR_ext]
setup(
    name="libR",
    ext_modules=extensions,
    cmdclass = {'build_ext': build_ext},
)
