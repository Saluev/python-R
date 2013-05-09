import sys
import os
import glob
#import numpy as np
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
include_paths = [paths[0][:-1]] + [os.path.join(path[:-1], "include") for path in paths[1:-1]] #+ [np.get_include()]
library_paths = [os.path.join(os.path.split(paths[0][:-1])[0], "lib")] + [os.path.join(path[:-1], "lib") for path in paths[1:-1]]
libraries = ['R', 'RInside']#, 'Rcpp']

print "Include paths:", ", ".join(include_paths)

src = ["libR.pyx", "libRaux.cpp"]
libR_ext = Extension("libR", src, language='c++', \
                                  include_dirs=include_paths, \
                                  library_dirs=library_paths, \
                                  runtime_library_dirs=library_paths, \
                                  libraries = libraries)

#data_files = []
#for i in range(len(libraries)):
#    data_files += glob.glob(os.path.join( library_paths[i], 'lib%s.*' % libraries[i] ))
#print "Files to copy:", ", ".join(data_files)

# finally, we can pass all this to distutils
extensions = [libR_ext]
setup(
    name="libR",
    version='0.1',
    author='Tigran Saluev',
    ext_modules=extensions,
    cmdclass = {'build_ext': build_ext},
    #data_files = ('.', data_files)
)
