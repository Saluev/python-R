#include <R.h>
#include <Rcpp.h>
#include <RInside.h>
#include <string>

using namespace std;
using namespace Rcpp;

namespace libRaux {
    
    #define sB(a) void setBinding(RInside *rinside, const string key, a *arg)
    
    sB(ComplexVector);
    sB(IntegerVector);
    sB(LogicalVector);
    sB(NumericVector);
    sB(StringVector);
    sB(List);
    sB(ExpressionVector);
    sB(ComplexMatrix);
    sB(IntegerMatrix);
    sB(LogicalMatrix);
    sB(NumericMatrix);
    sB(StringMatrix);
    sB(ListMatrix);
    sB(ExpressionMatrix);
    
    #define sgVv(a, b) void setValue(a *v, int i, b value); \
                      b getValue(a *v, int i)
    #define sgVm(a, b) void setValue(a *M, int i, int j, b value); \
                      b getValue(a *v, int i, int j)
    
    sgVv(ComplexVector, Rcomplex);
    sgVv(IntegerVector, long);
    sgVv(LogicalVector, bool);
    sgVv(NumericVector, double);
    sgVv(StringVector, const char*);
    // TODO: List, ExpressionVector
    sgVm(ComplexMatrix, Rcomplex);
    sgVm(IntegerMatrix, long);
    sgVm(LogicalMatrix, bool);
    sgVm(NumericMatrix, double);
    sgVm(StringMatrix, const char*);
    // TODO: ListMatrix, ExpressionMatrix
    
}

extern "C" {

    int main(int argc, char **argv);

}
