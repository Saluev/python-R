from libcpp cimport bool
from libcpp.string cimport string

ctypedef unsigned int SEXPTYPE


cdef extern from "R.h":
    
    # SEXPTYPE:
    # (actually these identifiers are #define'd integers.
    #  but integer template arguments are not supported by
    #  Cython in a straightforward way. So... yep, fuck me.)
    ctypedef SEXPTYPE NILSXP "NILSXP"
    ctypedef SEXPTYPE SYMSXP "SYMSXP"
    ctypedef SEXPTYPE LISTSXP "LISTSXP"
    ctypedef SEXPTYPE CLOSXP "CLOSXP"
    ctypedef SEXPTYPE ENVSXP "ENVSXP"
    ctypedef SEXPTYPE PROMSXP "PROMSXP"
    ctypedef SEXPTYPE LANGSXP "LANGSXP"
    ctypedef SEXPTYPE SPECIALSXP "SPECIALSXP"
    ctypedef SEXPTYPE BUILTINSXP "BUILTINSXP"
    ctypedef SEXPTYPE CHARSXP "CHARSXP"
    ctypedef SEXPTYPE LGLSXP "LGLSXP"
    ctypedef SEXPTYPE INTSXP "INTSXP"
    ctypedef SEXPTYPE REALSXP "REALSXP"
    ctypedef SEXPTYPE CPLXSXP "CPLXSXP"
    ctypedef SEXPTYPE STRSXP "STRSXP"
    ctypedef SEXPTYPE DOTSXP "DOTSXP"
    ctypedef SEXPTYPE ANYSXP "ANYSXP"
    ctypedef SEXPTYPE VECSXP "VECSXP"
    ctypedef SEXPTYPE EXPRSXP "EXPRSXP"
    ctypedef SEXPTYPE BCODESXP "BCODESXP"
    ctypedef SEXPTYPE EXTPTRSXP "EXTPTRSXP"
    ctypedef SEXPTYPE WEAKREFSXP "WEAKREFSXP"
    ctypedef SEXPTYPE RAWSXP "RAWSXP"
    ctypedef SEXPTYPE S4SXP "S4SXP"
    ctypedef SEXPTYPE FUNSXP "FUNSXP"
    
    ctypedef int R_len_t
    
    ctypedef struct Rcomplex:
        double r
        double i
    
    cdef struct sxpinfo_struct:
        SEXPTYPE type
        unsigned int obj
        unsigned int named
        unsigned int gp
        unsigned int mark
        unsigned int debug
        unsigned int trace
        unsigned int spare
        unsigned int gcgen
        unsigned int gccls
    
    cdef struct vecsxp_struct:
        R_len_t length
        R_len_t truelength

    cdef struct primsxp_struct:
        int offset

    cdef struct symsxp_struct:
        SEXPREC *pname
        SEXPREC *value
        SEXPREC *internal

    cdef struct listsxp_struct:
        SEXPREC *carval
        SEXPREC *cdrval
        SEXPREC *tagval

    cdef struct envsxp_struct:
        SEXPREC *frame
        SEXPREC *enclos
        SEXPREC *hashtab

    cdef struct closxp_struct:
        SEXPREC *formals
        SEXPREC *body
        SEXPREC *env

    cdef struct promsxp_struct:
        SEXPREC *value
        SEXPREC *expr
        SEXPREC *env
    
    ctypedef struct SEXPREC:
        sxpinfo_struct sxpinfo
        SEXPREC *attrib
        SEXPREC *gengc_next_node, *gengc_prev_node
        primsxp_struct primsxp   #
        symsxp_struct symsxp     #
        listsxp_struct listsxp   # a union
        envsxp_struct envsxp     #
        closxp_struct closxp     #
        promsxp_struct promsxp   #
    
    ctypedef SEXPREC *SEXP

cdef extern from "Rcpp.h" namespace "Rcpp":
    
    cdef cppclass RObject:
        pass
    
    cdef cppclass Environment:
        
        cppclass Binding:
            pass
            #Binding& operator=(const Binding& rhs)     # not supported yet
            #Binding& operator=(SEXP rhs)               # not supported yet
            #template [T] operator T() const # TODO: just enumerate this for necessary types
        
    
    # Actually template arguments of Vector and Matrix are ints. Nevermind.
    cdef cppclass Vector[T]:
        
        Vector()
        Vector(SEXP)
        Vector(const int&)
        
        #Proxy operator[](const int&)
    
    cdef cppclass Matrix[T]:
        
        Matrix()
        Matrix(SEXP)
        Matrix(const int&, const int&)
    
    ctypedef Vector[CPLXSXP] ComplexVector
    ctypedef Vector[INTSXP] IntegerVector
    ctypedef Vector[LGLSXP] LogicalVector
    ctypedef Vector[REALSXP] NumericVector
    ctypedef Vector[RAWSXP] RawVector

    ctypedef Vector[STRSXP] CharacterVector
    ctypedef Vector[STRSXP] StringVector
    ctypedef Vector[VECSXP] GenericVector
    ctypedef Vector[VECSXP] List
    ctypedef Vector[EXPRSXP] ExpressionVector

    ctypedef Matrix[CPLXSXP] ComplexMatrix
    ctypedef Matrix[INTSXP] IntegerMatrix
    ctypedef Matrix[LGLSXP] LogicalMatrix
    ctypedef Matrix[REALSXP] NumericMatrix
    ctypedef Matrix[RAWSXP] RawMatrix

    ctypedef Matrix[STRSXP] CharacterMatrix
    ctypedef Matrix[STRSXP] StringMatrix
    ctypedef Matrix[VECSXP] GenericMatrix
    ctypedef Matrix[VECSXP] ListMatrix
    ctypedef Matrix[EXPRSXP] ExpressionMatrix
    

cdef extern from "RInside.h":
    
    cdef cppclass RInside:
        
        cppclass RInsideProxy "Proxy":
            pass
        
        RInside()
        RInside(const int argc, const char** argv)
        RInside(const int argc, const char** argv,
            const bool loadRcpp, const bool verbose, const bool interactive)
        
        #Environment.Binding operator[](const string &name) # libRaux::setBinding instead
        
        int  parseEval(const string &line, SEXP &ans)       # parse line, return in ans error code rc
        void parseEvalQ(const string &line)                 # parse line, no return (throws on error)
        void parseEvalQNT(const string &line)               # parse line, no return (no throw)
        RInsideProxy parseEval(const string &line)          # parse line, return SEXP (throws on error)
        RInsideProxy parseEvalNT(const string &line)        # parse line, return SEXP (no throw)
        
    


cdef extern from "libRaux.h" namespace "libRaux":
    
    # because Cython does not support template functions yet.
    cdef void setBinding(RInside *rinside, const string key, ComplexVector *arg)
    cdef void setBinding(RInside *rinside, const string key, IntegerVector *arg)
    cdef void setBinding(RInside *rinside, const string key, LogicalVector *arg)
    cdef void setBinding(RInside *rinside, const string key, NumericVector *arg)
    cdef void setBinding(RInside *rinside, const string key, StringVector *arg)
    cdef void setBinding(RInside *rinside, const string key, List *arg)
    cdef void setBinding(RInside *rinside, const string key, ExpressionVector *arg)
    cdef void setBinding(RInside *rinside, const string key, ComplexMatrix *arg)
    cdef void setBinding(RInside *rinside, const string key, IntegerMatrix *arg)
    cdef void setBinding(RInside *rinside, const string key, LogicalMatrix *arg)
    cdef void setBinding(RInside *rinside, const string key, NumericMatrix *arg)
    cdef void setBinding(RInside *rinside, const string key, StringMatrix *arg)
    cdef void setBinding(RInside *rinside, const string key, ListMatrix *arg)
    cdef void setBinding(RInside *rinside, const string key, ExpressionMatrix *arg)
    
    cdef void setValue(ComplexVector *v, int i, Rcomplex value)
    cdef void setValue(IntegerVector *v, int i, int value)
    cdef void setValue(LogicalVector *v, int i, bool value)
    cdef void setValue(NumericVector *v, int i, double value)
    cdef void setValue(StringVector  *v, int i, const char *value)
    cdef void setValue(ComplexMatrix *v, int i, int j, Rcomplex value)
    cdef void setValue(IntegerMatrix *v, int i, int j, int value)
    cdef void setValue(LogicalMatrix *v, int i, int j, bool value)
    cdef void setValue(NumericMatrix *v, int i, int j, double value)
    cdef void setValue(StringMatrix  *v, int i, int j, const char *value)
    

from cython.operator import dereference as deref
from libc.stdlib cimport malloc, free

import numpy as np

cdef Rcomplex makeRcomplex(a):
    cdef Rcomplex result
    result.r = a.real
    result.i = a.imag
    return result

cdef class pyRInside:
    cdef RInside *rinside
    
    cdef object objects
    
    def __cinit__(self, const int argc, argv,
                        const bool loadRcpp = False,
                        const bool verbose = False,
                        const bool interactive = False):
        cdef char **cargv = <char**>malloc(sizeof(char*) * argc)
        for i in range(argc):
            strlen = len(argv[i])
            cargv[i] = <char*>malloc(sizeof(char) * (strlen + 1))
            for j in range(strlen):
                cargv[i][j] = argv[i][j]
            cargv[i][strlen] = 0
        self.rinside = new RInside(argc, cargv, loadRcpp, verbose, interactive)
        for i in range(argc):
            free(cargv[i])
        free(cargv)
        self.objects = {}
    
    def __dealloc__(self):
        del self.rinside
    
    #def __getitem__(self, key):
    #    cdef string ckey = key
    #    cdef Environment.Binding *result = &(deref(self.obj)[ckey])
    #    return None
    
    def __delitem(self, key):
        cdef void *obj
        if key in self.objects:
            obj = <void*>(self.objects[key])
            #del obj # TODO
            del self.objects[key]
    
    def __setitem__(self, key, val):
        cdef string ckey = key
        cdef void *obj
        a = np.asanyarray(val)
        d = len(a.shape)
        cdef int m = a.shape[0]
        cdef int n = a.shape[1] if d > 1 else 1
        if a.dtype in [np.bool, np.bool_, np.bool8]:
            # logical vector/matrix
            if d == 1:
                # a vector
                pass
            elif d == 2:
                # a matrix
                pass
            else:
                pass # TODO: exception
        elif a.dtype in [int, np.byte, np.short, np.intc, np.longlong, \
                              np.intp, np.int8, np.int16, np.int32, np.int64,
                              np.ubyte, np.ushort, np.uintc, np.uint, np.ulonglong,
                              np.uintp, np.uint8, np.uint16, np.uint21, np.uint64]:
            # integer vector/matrix
            if d == 1:
                # a vector
                pass
            elif d == 2:
                # a matrix
                pass
            else:
                pass # TODO: exception
        elif a.dtype in [float, np.half, np.single, np.double, np.longfloat, \
                                np.float16, np.float32, np.float64, np.float96, np.float128]:
            # numeric vector/matrix
            if d == 1:
                # a vector
                obj = <void*>(new NumericVector(m))
                self.objects[key] = <long>obj
                for i in range(m):
                    setValue(<NumericVector*>obj, i, <double>(a[i]))
                setBinding(self.rinside, ckey, <NumericVector*>obj)
            elif d == 2:
                # a matrix
                obj = <void*>(new NumericMatrix(m, n))
                self.objects[key] = <long>obj
                for i in range(m):
                    for j in range(n):
                        setValue(<NumericMatrix*>obj, i, j, <double>(a[i, j]))
                setBinding(self.rinside, ckey, <NumericMatrix*>obj)
            else:
                pass # TODO: exception
        elif a.dtype in [complex, np.csingle, np.clongfloat, np.complex64, \
                                  np.complex128, np.complex192, np.complex256]:
            # complex vector/matrix
            if d == 1:
                # a vector
                obj = <void*>(new ComplexVector(m))
                self.objects[key] = <long>obj
                for i in range(m):
                    setValue(<ComplexVector*>obj, i, makeRcomplex(a[i]))
                setBinding(self.rinside, ckey, <ComplexVector*>obj)
            elif d == 2:
                # a matrix
                obj = <void*>(new ComplexMatrix(m, n))
                self.objects[key] = <long>obj
                for i in range(m):
                    for j in range(n):
                        setValue(<ComplexMatrix*>obj, i, j, makeRcomplex(a[i, j]))
                setBinding(self.rinside, ckey, <ComplexMatrix*>obj)
            else:
                pass # TODO: exception
        else:
            # something else
            pass
        
    
    



