from libcpp cimport bool
from libcpp.string cimport string

ctypedef unsigned int SEXPTYPE


cdef extern from "R.h":
    
    ctypedef int R_len_t
    
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
        R_len_t	length
        R_len_t	truelength

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
        

cdef extern from "RInside.h":
    
    cdef cppclass RInside:
        
        cppclass Proxy:
            pass
        
        RInside()
        RInside(const int argc, const char** argv)
        RInside(const int argc, const char** argv,
            const bool loadRcpp, const bool verbose, const bool interactive)
        
        Environment.Binding operator[](const string &name)
        
        int  parseEval(const string &line, SEXP &ans)       # parse line, return in ans error code rc
        void parseEvalQ(const string &line)                 # parse line, no return (throws on error)
        void parseEvalQNT(const string &line)               # parse line, no return (no throw)
        Proxy parseEval(const string &line)                 # parse line, return SEXP (throws on error)
        Proxy parseEvalNT(const string &line)	            # parse line, return SEXP (no throw)
        
    

cdef extern from "libRaux.h" namespace "libRaux":
    
    cdef void setBinding(RInside *rinside, const string key, SEXP arg)
    cdef void setBinding(RInside *rinside, const string key, const Environment.Binding &arg)
    

from cython.operator import dereference as deref
from libc.stdlib cimport malloc, free

cdef class pyRInside:
    cdef RInside *obj
    
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
        self.obj = new RInside(argc, cargv, loadRcpp, verbose, interactive)
        for i in range(argc):
            free(cargv[i])
        free(cargv)
    
    def __dealloc__(self):
        del self.obj
    
    def __getitem__(self, key):
        cdef string ckey = key
        cdef Environment.Binding *result = &(deref(self.obj)[ckey])
        return None
    



