from libcpp cimport bool
from libcpp.string cimport string

#ctypedef unsigned int SEXPTYPE

cdef enum mySEXPTYPE:
        NILSXP      = 0,
        SYMSXP      = 1,
        LISTSXP        = 2,
        CLOSXP      = 3,
        ENVSXP      = 4,
        PROMSXP        = 5,
        LANGSXP        = 6,
        SPECIALSXP  = 7,
        BUILTINSXP  = 8,
        CHARSXP        = 9,
        LGLSXP      = 10,
        INTSXP      = 13,
        REALSXP        = 14,
        CPLXSXP        = 15,
        STRSXP      = 16,
        DOTSXP      = 17,
        ANYSXP      = 18,
        VECSXP      = 19,
        EXPRSXP        = 20,
        BCODESXP    = 21,
        EXTPTRSXP   = 22,
        WEAKREFSXP  = 23,
        RAWSXP      = 24,
        S4SXP       = 25,
        FUNSXP      = 99

cdef extern from "R.h":
    
    # SEXPTYPE:
    # (actually these identifiers are #define'd integers.
    #  but integer template arguments are not supported by
    #  Cython in a straightforward way. So... yep, fuck me.)
    ctypedef unsigned int NILSXP_t "NILSXP"
    ctypedef unsigned int SYMSXP_t "SYMSXP"
    ctypedef unsigned int LISTSXP_t "LISTSXP"
    ctypedef unsigned int CLOSXP_t "CLOSXP"
    ctypedef unsigned int ENVSXP_t "ENVSXP"
    ctypedef unsigned int PROMSXP_t "PROMSXP"
    ctypedef unsigned int LANGSXP_t "LANGSXP"
    ctypedef unsigned int SPECIALSXP_t "SPECIALSXP"
    ctypedef unsigned int BUILTINSXP_t "BUILTINSXP"
    ctypedef unsigned int CHARSXP_t "CHARSXP"
    ctypedef unsigned int LGLSXP_t "LGLSXP"
    ctypedef unsigned int INTSXP_t "INTSXP"
    ctypedef unsigned int REALSXP_t "REALSXP"
    ctypedef unsigned int CPLXSXP_t "CPLXSXP"
    ctypedef unsigned int STRSXP_t "STRSXP"
    ctypedef unsigned int DOTSXP_t "DOTSXP"
    ctypedef unsigned int ANYSXP_t "ANYSXP"
    ctypedef unsigned int VECSXP_t "VECSXP"
    ctypedef unsigned int EXPRSXP_t "EXPRSXP"
    ctypedef unsigned int BCODESXP_t "BCODESXP"
    ctypedef unsigned int EXTPTRSXP_t "EXTPTRSXP"
    ctypedef unsigned int WEAKREFSXP_t "WEAKREFSXP"
    ctypedef unsigned int RAWSXP_t "RAWSXP"
    ctypedef unsigned int S4SXP_t "S4SXP"
    ctypedef unsigned int FUNSXP_t "FUNSXP"
    
    ctypedef unsigned int SEXPTYPE
    
    ctypedef int R_len_t
    ctypedef bool Rboolean
    ctypedef unsigned char Rbyte
    
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
    
    cdef SEXP    R_Bracket2Symbol
    cdef SEXP    R_BracketSymbol
    cdef SEXP    R_BraceSymbol
    cdef SEXP    R_ClassSymbol
    cdef SEXP    R_DeviceSymbol
    cdef SEXP    R_DimNamesSymbol
    cdef SEXP    R_DimSymbol
    cdef SEXP    R_DollarSymbol
    cdef SEXP    R_DotsSymbol
    cdef SEXP    R_DropSymbol
    cdef SEXP    R_LastvalueSymbol
    cdef SEXP    R_LevelsSymbol
    cdef SEXP    R_ModeSymbol
    cdef SEXP    R_NameSymbol
    cdef SEXP    R_NamesSymbol
    cdef SEXP    R_NaRmSymbol
    cdef SEXP   R_PackageSymbol
    cdef SEXP   R_QuoteSymbol
    cdef SEXP    R_RowNamesSymbol
    cdef SEXP    R_SeedsSymbol
    cdef SEXP    R_SourceSymbol
    cdef SEXP    R_TspSymbol
    cdef SEXP   R_GlobalEnv
    cdef SEXP   R_EmptyEnv
    cdef SEXP   R_BaseEnv
    cdef SEXP   R_BaseNamespace
    cdef SEXP   R_NamespaceRegistry
    cdef SEXP   R_NilValue
    cdef SEXP   R_UnboundValue
    cdef SEXP   R_MissingArg
    
    Rboolean Rf_isNull(SEXP s)
    Rboolean Rf_isSymbol(SEXP s)
    Rboolean Rf_isLogical(SEXP s)
    Rboolean Rf_isReal(SEXP s)
    Rboolean Rf_isComplex(SEXP s)
    Rboolean Rf_isExpression(SEXP s)
    Rboolean Rf_isEnvironment(SEXP s)
    Rboolean Rf_isString(SEXP s)
    Rboolean Rf_isObject(SEXP s)
    
    Rboolean Rf_isArray(SEXP)
    Rboolean Rf_isFactor(SEXP)
    Rboolean Rf_isFrame(SEXP)
    Rboolean Rf_isFunction(SEXP)
    Rboolean Rf_isInteger(SEXP)
    Rboolean Rf_isLanguage(SEXP)
    Rboolean Rf_isList(SEXP)
    Rboolean Rf_isMatrix(SEXP)
    Rboolean Rf_isNewList(SEXP)
    Rboolean Rf_isNumber(SEXP)
    Rboolean Rf_isNumeric(SEXP)
    Rboolean Rf_isPairList(SEXP)
    Rboolean Rf_isPrimitive(SEXP)
    Rboolean Rf_isTs(SEXP)
    Rboolean Rf_isUserBinop(SEXP)
    Rboolean Rf_isValidString(SEXP)
    Rboolean Rf_isValidStringF(SEXP)
    Rboolean Rf_isVector(SEXP)
    Rboolean Rf_isVectorAtomic(SEXP)
    Rboolean Rf_isVectorList(SEXP)
    Rboolean Rf_isVectorizable(SEXP)
    
    SEXP ATTRIB(SEXP x)
    int  OBJECT(SEXP x)
    int  MARK(SEXP x)
    int  TYPEOF(SEXP x)
    int  NAMED(SEXP x)
    void SET_OBJECT(SEXP x, int v)
    void SET_TYPEOF(SEXP x, int v)
    void SET_NAMED(SEXP x, int v)
    void SET_ATTRIB(SEXP x, SEXP v)
    void DUPLICATE_ATTRIB(SEXP to, SEXP frm)
    
    int IS_S4_OBJECT(SEXP x)
    void SET_S4_OBJECT(SEXP x)
    void UNSET_S4_OBJECT(SEXP x)
    
    # Vector Access Functions
    int  LENGTH(SEXP x)
    int  TRUELENGTH(SEXP x)
    void SETLENGTH(SEXP x, int v)
    void SET_TRUELENGTH(SEXP x, int v)
    int  LEVELS(SEXP x)
    int  SETLEVELS(SEXP x, int v)
    
    #void *DATAPTR(SEXP x)    # this is actually a macro
    const char *CHAR(SEXP x) # this is actually a macro
    const char *R_CHAR(SEXP x)
    int  *LOGICAL(SEXP x)
    int  *INTEGER(SEXP x)
    Rbyte *RAW(SEXP x)
    double *REAL(SEXP x)
    Rcomplex *COMPLEX(SEXP x)
    SEXP STRING_ELT(SEXP x, int i)
    SEXP VECTOR_ELT(SEXP x, int i)
    void SET_STRING_ELT(SEXP x, int i, SEXP v)
    SEXP SET_VECTOR_ELT(SEXP x, int i, SEXP v)
    SEXP *STRING_PTR(SEXP x)
    SEXP *VECTOR_PTR(SEXP x)
    
    
    
    
    SEXP Rf_asChar(SEXP)
    SEXP Rf_coerceVector(SEXP, SEXPTYPE)
    SEXP Rf_PairToVectorList(SEXP x)
    SEXP Rf_VectorToPairList(SEXP x)
    SEXP Rf_asCharacterFactor(SEXP x)
    int Rf_asLogical(SEXP x)
    int Rf_asInteger(SEXP x)
    double Rf_asReal(SEXP x)
    Rcomplex Rf_asComplex(SEXP x)
    
    char * Rf_acopy_string(const char *)
    SEXP Rf_alloc3DArray(SEXPTYPE, int, int, int)
    SEXP Rf_allocArray(SEXPTYPE, SEXP)
    SEXP Rf_allocMatrix(SEXPTYPE, int, int)
    SEXP Rf_allocList(int)
    SEXP Rf_allocS4Object()
    SEXP Rf_allocSExp(SEXPTYPE)
    SEXP Rf_allocVector(SEXPTYPE, R_len_t)
    int  Rf_any_duplicated(SEXP x, Rboolean from_last)
    int  Rf_any_duplicated3(SEXP x, SEXP incomp, Rboolean from_last)
    SEXP Rf_applyClosure(SEXP, SEXP, SEXP, SEXP, SEXP)
    SEXP Rf_arraySubscript(int, SEXP, SEXP, SEXP (*)(SEXP,SEXP),
                           SEXP (*)(SEXP, int), SEXP)
    Rcomplex Rf_asComplex(SEXP)
    int Rf_asInteger(SEXP)
    int Rf_asLogical(SEXP)
    double Rf_asReal(SEXP)
    SEXP Rf_classgets(SEXP, SEXP)
    SEXP Rf_cons(SEXP, SEXP)
    Rboolean R_compute_identical(SEXP, SEXP, Rboolean num_eq,
                     Rboolean single_NA, Rboolean attr_asSet)
    void Rf_copyMatrix(SEXP, SEXP, Rboolean)
    void Rf_copyMostAttrib(SEXP, SEXP)
    void Rf_copyVector(SEXP, SEXP)
    int Rf_countContexts(int, int)
    SEXP Rf_CreateTag(SEXP)
    void Rf_defineVar(SEXP, SEXP, SEXP)
    SEXP Rf_dimgets(SEXP, SEXP)
    SEXP Rf_dimnamesgets(SEXP, SEXP)
    SEXP Rf_DropDims(SEXP)
    SEXP Rf_duplicate(SEXP)
    SEXP Rf_duplicated(SEXP, Rboolean)
    SEXP Rf_eval(SEXP, SEXP)
    SEXP Rf_findFun(SEXP, SEXP)
    SEXP Rf_findVar(SEXP, SEXP)
    SEXP Rf_findVarInFrame(SEXP, SEXP)
    SEXP Rf_findVarInFrame3(SEXP, SEXP, Rboolean)
    SEXP Rf_getAttrib(SEXP, SEXP)
    SEXP Rf_GetArrayDimnames(SEXP)
    SEXP Rf_GetColNames(SEXP)
    void Rf_GetMatrixDimnames(SEXP, SEXP*, SEXP*, const char**, const char**)
    SEXP Rf_GetOption(SEXP, SEXP)
    int Rf_GetOptionDigits(SEXP)
    int Rf_GetOptionWidth(SEXP)
    SEXP Rf_GetRowNames(SEXP)
    void Rf_gsetVar(SEXP, SEXP, SEXP)
    SEXP Rf_install(const char *)
    Rboolean Rf_isFree(SEXP)
    Rboolean Rf_isOrdered(SEXP)
    Rboolean Rf_isUnordered(SEXP)
    Rboolean Rf_isUnsorted(SEXP, Rboolean)
    SEXP Rf_lengthgets(SEXP, R_len_t)
    SEXP R_lsInternal(SEXP, Rboolean)
    SEXP Rf_match(SEXP, SEXP, int)
    SEXP Rf_namesgets(SEXP, SEXP)
    SEXP Rf_mkChar(const char *)
    SEXP Rf_mkCharLen(const char *, int)
    Rboolean Rf_NonNullStringMatch(SEXP, SEXP)
    int Rf_ncols(SEXP)
    int Rf_nrows(SEXP)
    SEXP Rf_nthcdr(SEXP, int)
    
    Rboolean Rf_pmatch(SEXP, SEXP, Rboolean)
    Rboolean Rf_psmatch(const char *, const char *, Rboolean)
    void Rf_PrintValue(SEXP)
    SEXP Rf_protect(SEXP)
    SEXP Rf_setAttrib(SEXP, SEXP, SEXP)
    void Rf_setSVector(SEXP*, int, SEXP)
    void Rf_setVar(SEXP, SEXP, SEXP)
    SEXPTYPE Rf_str2type(const char *)
    Rboolean Rf_StringBlank(SEXP)
    SEXP Rf_substitute(SEXP,SEXP)
    const char * Rf_translateChar(SEXP)
    const char * Rf_translateCharUTF8(SEXP)
    const char * Rf_type2char(SEXPTYPE)
    SEXP Rf_type2str(SEXPTYPE)
    void Rf_unprotect(int)
    void Rf_unprotect_ptr(SEXP)
    
    #void R_ProtectWithIndex(SEXP, PROTECT_INDEX *)
    #void R_Reprotect(SEXP, PROTECT_INDEX)
    SEXP R_tryEval(SEXP, SEXP, int *)
    
    Rboolean Rf_isS4(SEXP)
    SEXP Rf_asS4(SEXP, Rboolean, int)
    SEXP Rf_S3Class(SEXP)
    int Rf_isBasicClass(const char *)
    
    Rboolean Rf_conformable(SEXP, SEXP)
    SEXP     Rf_elt(SEXP, int)
    Rboolean Rf_inherits(SEXP, const char *)
    Rboolean Rf_isArray(SEXP)
    Rboolean Rf_isFactor(SEXP)
    Rboolean Rf_isFrame(SEXP)
    Rboolean Rf_isFunction(SEXP)
    Rboolean Rf_isInteger(SEXP)
    Rboolean Rf_isLanguage(SEXP)
    Rboolean Rf_isList(SEXP)
    Rboolean Rf_isMatrix(SEXP)
    Rboolean Rf_isNewList(SEXP)
    Rboolean Rf_isNumber(SEXP)
    Rboolean Rf_isNumeric(SEXP)
    Rboolean Rf_isPairList(SEXP)
    Rboolean Rf_isPrimitive(SEXP)
    Rboolean Rf_isTs(SEXP)
    Rboolean Rf_isUserBinop(SEXP)
    Rboolean Rf_isValidString(SEXP)
    Rboolean Rf_isValidStringF(SEXP)
    Rboolean Rf_isVector(SEXP)
    Rboolean Rf_isVectorAtomic(SEXP)
    Rboolean Rf_isVectorList(SEXP)
    Rboolean Rf_isVectorizable(SEXP)
    SEXP     Rf_lang1(SEXP)
    SEXP     Rf_lang2(SEXP, SEXP)
    SEXP     Rf_lang3(SEXP, SEXP, SEXP)
    SEXP     Rf_lang4(SEXP, SEXP, SEXP, SEXP)
    SEXP     Rf_lastElt(SEXP)
    SEXP     Rf_lcons(SEXP, SEXP)
    R_len_t  Rf_length(SEXP)
    SEXP     Rf_list1(SEXP)
    SEXP     Rf_list2(SEXP, SEXP)
    SEXP     Rf_list3(SEXP, SEXP, SEXP)
    SEXP     Rf_list4(SEXP, SEXP, SEXP, SEXP)
    SEXP     Rf_listAppend(SEXP, SEXP)
    SEXP     Rf_mkNamed(int, const char **)
    SEXP     Rf_mkString(const char *)
    int      Rf_nlevels(SEXP)
    SEXP     Rf_ScalarComplex(Rcomplex)
    SEXP     Rf_ScalarInteger(int)
    SEXP     Rf_ScalarLogical(int)
    SEXP     Rf_ScalarRaw(Rbyte)
    SEXP     Rf_ScalarReal(double)
    SEXP     Rf_ScalarString(SEXP)



cdef extern from "Rcpp.h" namespace "Rcpp":
    
    cdef cppclass RObject:
        
        int sexp_type() const
    
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
        
        R_len_t length() const
        R_len_t size() const
        
        SEXP operator[](const int& i) const
        SEXP operator()(const int& i) const
        
    
    cdef cppclass Matrix[T]:
        
        Matrix()
        Matrix(SEXP)
        Matrix(const int&, const int&)
        
        R_len_t length() const
        R_len_t size() const
        int ncol() const
        int nrow() const
        int cols() const
        int rows() const
        
        SEXP operator()(const int& i, const int& j) const
        
    
    ctypedef Vector[CPLXSXP_t] ComplexVector
    ctypedef Vector[INTSXP_t] IntegerVector
    ctypedef Vector[LGLSXP_t] LogicalVector
    ctypedef Vector[REALSXP_t] NumericVector
    ctypedef Vector[RAWSXP_t] RawVector

    ctypedef Vector[STRSXP_t] CharacterVector
    ctypedef Vector[STRSXP_t] StringVector
    ctypedef Vector[VECSXP_t] GenericVector
    ctypedef Vector[VECSXP_t] List
    ctypedef Vector[EXPRSXP_t] ExpressionVector

    ctypedef Matrix[CPLXSXP_t] ComplexMatrix
    ctypedef Matrix[INTSXP_t] IntegerMatrix
    ctypedef Matrix[LGLSXP_t] LogicalMatrix
    ctypedef Matrix[REALSXP_t] NumericMatrix
    ctypedef Matrix[RAWSXP_t] RawMatrix

    ctypedef Matrix[STRSXP_t] CharacterMatrix
    ctypedef Matrix[STRSXP_t] StringMatrix
    ctypedef Matrix[VECSXP_t] GenericMatrix
    ctypedef Matrix[VECSXP_t] ListMatrix
    ctypedef Matrix[EXPRSXP_t] ExpressionMatrix
    

cdef extern from "RInside.h":
    
    cdef cppclass RInside:
        
        cppclass RInsideProxy "Proxy":
            pass
        
        RInside()
        RInside(const int argc, const char** argv)
        RInside(const int argc, const char** argv,
            const bool loadRcpp, const bool verbose, const bool interactive)
        
        SEXP operator[](const string &name)
        
        int  parseEval(const string &line, SEXP &ans)       # parse line, return in ans error code rc
        void parseEvalQ(const string &line)                 # parse line, no return (throws on error)
        void parseEvalQNT(const string &line)               # parse line, no return (no throw)
        SEXP parseEval(const string &line)                  # parse line, return SEXP (throws on error)
        SEXP parseEvalNT(const string &line)                # parse line, return SEXP (no throw)
        
    

cdef extern from "libRaux.h" namespace "libRaux":
    
    cdef void setBinding(RInside *rinside, const string key, SEXP arg)
    cdef SEXP getBinding(RInside *rinside, const string key)
    

from cython.operator import dereference as deref
from libc.string cimport memcpy
from libc.stdlib cimport malloc, free

import numpy as np
cimport numpy as np
from cpython cimport PyObject, Py_INCREF
from cpython.object cimport Py_SIZE
np.import_array()

cdef Rcomplex makeRcomplex(a):
    cdef Rcomplex result
    result.r = a.real
    result.i = a.imag
    return result

cdef object makePyComplex(Rcomplex a):
    return float(a.r) + 1j * float(a.i)

cdef object SEXPToObject(SEXP arg):
    cdef int t = TYPEOF(arg)
    cdef void *tmp
    cdef SEXP t1, t2, t3
    cdef np.npy_intp npshape[2]
    cdef Py_ssize_t i, j
    result = None
    if Rf_isNull(arg):
        result = None
    elif Rf_isNewList(arg): # because Rf_isList is too fucking old.
        size = LENGTH(arg)
        t1 = Rf_getAttrib(arg, R_NamesSymbol)
        if not Rf_isNull(t1):
            result = {}
            for i in range(size):
                key = str(CHAR(STRING_ELT(t1, i)))
                value = SEXPToObject(VECTOR_ELT(arg, i))
                result[key] = value
        else:
            result = []
            for i in range(size):
                value = SEXPToObject(VECTOR_ELT(arg, i))
                result.append(value)
    elif Rf_isString(arg):
        size = LENGTH(arg)
        result = []
        for i in range(size):
            result.append(str(CHAR(STRING_ELT(arg, i))))
        if size == 1:
            result = result[0]
        else:
            result = np.array(result, dtype=str)
            t1 = Rf_getAttrib(arg, R_DimSymbol)
            dims = SEXPToObject(t1)
            if dims != None:
                result = result.reshape(dims, order='F')
    # NOTE: matrices in R are kept in column-wise (Fortran) order.
    elif Rf_isComplex(arg):
        tmp = <void*>COMPLEX(arg)
        size = LENGTH(arg)
        result = np.zeros(size, dtype=np.complex)
        for i in range(size):
            result[i] = makePyComplex((<Rcomplex*>tmp)[i])
        if size == 1:
            result = result[0]
        else:
            t1 = Rf_getAttrib(arg, R_DimSymbol)
            dims = SEXPToObject(t1)
            if dims != None:
                result = result.reshape(dims, order='F')
    elif Rf_isNumber(arg):
        dtype = None
        if Rf_isLogical(arg):
            tmp = <void*>LOGICAL(arg)
            dtype = np.NPY_INT
        elif Rf_isInteger(arg):
            tmp = <void*>INTEGER(arg)
            dtype = np.NPY_INT
        elif Rf_isReal(arg):
            tmp = <void*>REAL(arg)
            dtype = np.NPY_DOUBLE
        size = LENGTH(arg)
        npshape[0] = size
        result = np.PyArray_SimpleNewFromData(1, npshape, dtype, tmp)
        if Rf_isLogical(arg):
            result = np.array(result, dtype=np.bool)
        if size == 1:
            result = result[0]
        else:
            t1 = Rf_getAttrib(arg, R_DimSymbol)
            dims = SEXPToObject(t1)
            if dims != None:
                result = result.reshape(dims, order='F')
    elif Rf_isObject(arg):
        # TODO: objects (wtf are objects?)
        pass
    else:
        print "ERROR: unsupported object type"
        pass # TODO: "not implemented" exception
    
    return result
    

cdef SEXP ObjectToSEXP(object arg):
    cdef SEXP result = NULL, tmp
    cdef Py_ssize_t i, j
    cdef np.ndarray nparg
    cdef void *ptmp
    if isinstance(arg, np.ndarray) and arg.dtype == object:
        # NumPy array with unspecified type is going to become a f-king list of lists.
        arg = list(arg)
    if arg == None: 
        result = R_NilValue
    elif isinstance(arg, str):
        result = Rf_ScalarString(Rf_mkChar(<const char*>arg))
        #size = len(arg)
        #result = Rf_allocVector(STRSXP, 1)
        #tmp = Rf_mkChar(<const char*>arg)
        #SET_STRING_ELT(result, 0, tmp)
    elif isinstance(arg, (list, tuple)):
        size = len(arg)
        result = Rf_allocVector(VECSXP, size)
        for i in range(size):
            SET_VECTOR_ELT(result, i, ObjectToSEXP(arg[i]))
    elif isinstance(arg, dict):
        size = len(arg)
        items = arg.items()
        result = Rf_allocVector(VECSXP, size)
        tmp = Rf_allocVector(STRSXP, size)
        Rf_protect(tmp)
        for i in range(size):
            strkey = str(items[i][0]) # TODO: alternative version using repr()
            SET_STRING_ELT(tmp, i, Rf_mkChar(<const char*>strkey))
            SET_VECTOR_ELT(result, i, ObjectToSEXP(items[i][1]))
        Rf_setAttrib(result, R_NamesSymbol, tmp)
        Rf_unprotect(1 + size)
    elif isinstance(arg, int):
        result = Rf_ScalarInteger(arg)
    elif isinstance(arg, np.bool): # FIXME: wtf, True turns to 1
        result = Rf_ScalarLogical(1 if arg else 0)
    elif isinstance(arg, complex):
        result = Rf_ScalarComplex(makeRcomplex(arg))
    elif isinstance(arg, float):
        result = Rf_ScalarReal(arg)
    elif isinstance(arg, np.ndarray):
        #nparg = arg.copy(order='F') # hope to normalize data storage in memory
        nparg = arg.flatten(order='F')
        
        d = len(arg.shape)
        size = nparg.size
        
        sextype = None
        
        sextype = int(arg.dtype in [np.float64]   and int(REALSXP)) or \
                  int(arg.dtype in [complex] and int(CPLXSXP)) or \
                  int(arg.dtype in [int]     and int(INTSXP )) or \
                  int(arg.dtype in [np.bool] and int(LGLSXP )) or \
                  int(arg.dtype in [str, np.dtype('S1')] and int(STRSXP )) # string arrays FTW!
        
        print sextype
        print sizeof(int)
        result = Rf_allocVector(sextype, nparg.size)
        
        if sextype == REALSXP:
            datasize = sizeof(double)
            nparg = np.array(nparg, dtype=np.dtype('f%d' % datasize))
            memcpy(REAL(result), nparg.data, size * datasize)
        elif sextype == CPLXSXP:
            datasize = sizeof(Rcomplex)
            nparg = np.array(nparg, dtype=np.dtype('c%d' % datasize))
            memcpy(COMPLEX(result), nparg.data, size * datasize) # TODO: is order correct?
            #for i in range(size):
            #    COMPLEX(result)[i] = makeRcomplex(nparg[i])
        elif sextype == INTSXP:
            datasize = sizeof(int)
            nparg = np.array(nparg, dtype=np.dtype('i%d' % datasize))
            memcpy(INTEGER(result), nparg.data, size * datasize)
        elif sextype == LGLSXP:
            datasize = sizeof(int)
            nparg = np.array(nparg, dtype=np.dtype('i%d' % datasize))
            memcpy(LOGICAL(result), nparg.data, size * datasize)
        elif sextype == STRSXP:
            for i in range(size):
                value = str(nparg[i])
                SET_STRING_ELT(result, i, Rf_mkChar(<const char*>value))
        
        tmp = Rf_allocVector(INTSXP, d)
        for i in range(d):
            INTEGER(tmp)[i] = arg.shape[i]
        Rf_setAttrib(result, R_DimSymbol, tmp)
    else:
        print "ERROR: unsupported object type"
        result = R_NilValue
    Rf_protect(result)
    return result

cdef class pyRInside:
    cdef RInside *rinside
    
    cdef object objects
    
    def __cinit__(self, argv = [], bool loadRcpp = False, bool verbose = False, bool interactive  = False):
        cdef int argc = len(argv)
        cdef char **cargv = <char**>malloc(sizeof(char*) * argc)
        cdef int i, j
        for i in range(argc):
            strlen = len(argv[i])
            ###cargv[i] = <char*>(argv[i]) # glibc detected
            cargv[i] = <char*>malloc(sizeof(char) * (strlen + 1))
            for j in range(strlen):
                cargv[i][j] = argv[i][j] # TODO: wtf?
            cargv[i][strlen] = 0
        self.rinside = new RInside(argc, cargv, loadRcpp, verbose, interactive)
        for i in range(argc):
            free(cargv[i])
        free(cargv)
    
    def __dealloc__(self):
        del self.rinside
    
    def __delitem__(self, key):
        key = str(key)
        self.rinside.parseEvalQ("rm(%s)" % key)
    
    def __getitem__(self, key):
        cdef string ckey = key
        return SEXPToObject(deref(self.rinside)[ckey])
        #return SEXPToObject(getBinding(self.rinside, ckey))
    
    def __setitem__(self, key, val):
        cdef string ckey = key
        setBinding(self.rinside, ckey, ObjectToSEXP(val))
        Rf_unprotect(1)
        
    def parseEval(self, expr):
        """ Evaluate R code expr, return result. Throws exceptions. """
        cdef string cexpr = expr
        cdef SEXP result = self.rinside.parseEval(cexpr)
        return SEXPToObject(result)
    
    def parseEvalNT(self, expr):
        """ Evaluate R code expr, return result. Doesn't throw exceptions. """
        cdef string cexpr = expr
        cdef SEXP result = self.rinside.parseEvalNT(cexpr)
        return SEXPToObject(result)
    
    def parseEvalQ(self, expr):
        """ Evaluate R code expr, ignore result. Throws exceptions. """
        cdef string cexpr = expr
        self.rinside.parseEvalQ(cexpr)
    
    def parseEvalQNT(self, expr):
        """ Evaluate R code expr, ignore result. Doesn't throw exceptions. """
        cdef string cexpr = expr
        self.rinside.parseEvalQNT(expr)
    



