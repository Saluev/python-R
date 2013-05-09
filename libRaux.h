#include <R.h>
#include <Rinternals.h>
#include <Rcpp.h>
#include <RInside.h>
#include <string>

using namespace std;
using namespace Rcpp;

namespace libRaux {
    
    void setBinding(RInside *rinside, const string key, SEXP arg);
    SEXP getBinding(RInside *rinside, const string key);
    
}

