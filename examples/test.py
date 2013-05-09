#!/usr/local/bin/python
import sys
import libR as R
rinside = R.pyRInside()
print "List demo:"
print rinside.parseEval("list(1, FALSE, 3i, 4)")
print "Matrix demo:\n  matrix in R:"
print rinside.parseEval("print(array(1:20, dim=c(4,5))); cat(\"  matrix in Python:\\n\"); array(1:20, dim=c(4,5))")

# String list demo
#print rinside.parseEval("c(\"1\", \"2\")")

import numpy as np

M = np.ones((2, 3), dtype=str)
M[0, 1] = 'a'
M[1, 0] = 'b'
M[1, 2] = 'c'

M = np.zeros((2,3))
M[0, 1] = 1
M[1, 0] = 2
M[1, 2] = 3
#print M

print "Dict demo:"
print "  dict in Python:"
myvar = {"a": "abc", "b": 12, "c": True, "d": 175.1343533, "e": 16j, 1: M}
print myvar
rinside["myvar"] = myvar
print "  dict from R:"
print rinside["myvar"]
print "  dict in R itself:"
rinside.parseEval("print(myvar); 1")
# variable deletion demo
del rinside["myvar"]
